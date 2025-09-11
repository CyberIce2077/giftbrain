module Affiliate
  module Aliexpress
    module Products
      class ListService < BaseService
        class ApiError < StandardError; end

        URL = "https://api-sg.aliexpress.com/sync".freeze

        attr_reader :keywords, :ship_to_country, :page_no

        def initialize(keywords:, ship_to_country: "US", page_no: 1)
          super
          @keywords = keywords
          @ship_to_country = ship_to_country
          @page_no = page_no
        end

        def call
          response = aliexpress_client.get do |r|
            r.params = build_params
          end

          result = response.body
          validate_result!(result)

          result = result.dig("aliexpress_affiliate_product_query_response", "resp_result", "result")

          products = result.dig("products", "product")
          total_count = result.dig("total_record_count")

          @data = { products:, total_count: }
          validate_data_presence!

          success!
        rescue StandardError => e
          errors.add(:base, e.message)
          log_error(e)
        end

        private

        def validate_result!(result)
          return if result.dig("aliexpress_affiliate_product_query_response", "resp_result", "result", "products", "product").present?

          raise ApiError, "Invalid API response"
        end

        def aliexpress_client
          Faraday.new(URL) do |conn|
            conn.response :json
            conn.request :json
            conn.adapter Faraday.default_adapter
          end
        end

        def build_params
          params = {
            "method" => "aliexpress.affiliate.product.query",
            "keywords" => keywords,
            "ship_to_country" => ship_to_country,
            "page_no" => page_no,
            "page_size" => 20,
            "sign_method" => "sha256",
            "app_key" => app_key,
            "timestamp" => (Time.now.to_f * 1000).to_i
          }

          params["sign"] = encrypted_sign(params)

          params
        end

        def encrypted_sign(params)
          sort_params = params.sort.to_h

          sign_params = ""

          sort_params.each do |k, v|
            sign_params += k.to_s
            sign_params += v.to_s
          end

          OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new("sha256"), app_secret, sign_params).upcase
        end

        def app_key
          Rails.application.credentials.dig(:affiliate, :aliexpress, :app_key)
        end

        def app_secret
          Rails.application.credentials.dig(:affiliate, :aliexpress, :app_secret)
        end
      end
    end
  end
end
