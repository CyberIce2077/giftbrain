module Affiliate
  module Aliexpress
    class GenerateAffiliateLinkService < BaseService
      class PromotionLinkError < StandardError; end

      URL = "https://api-sg.aliexpress.com/sync".freeze

      attr_reader :keywords, :ship_to_country

      def initialize(keywords, ship_to_country = "US")
        super
        @keywords = keywords
        @ship_to_country = ship_to_country
      end

      def call
        response = HTTP.get("#{URL}?#{URI.encode_www_form(build_params)}")

        product_response = parse_response(response)

        validate_product_response!(product_response)

        @data = product_response

        success!
      rescue StandardError => e
        errors.add(:base, e.message)
        log_error(e)
      end

      private

      def validate_product_response!(product_response)
        raise PromotionLinkError, "Promotion link is missing" if product_response["promotion_link"].blank?

        unless product_response["promotion_link"].start_with?("https://s.click.aliexpress.com")
          raise PromotionLinkError, "Promotion link is invalid"
        end
      end

      def parse_response(response)
        result = JSON.parse(response.body.to_s)
                     .dig("aliexpress_affiliate_product_query_response",
                          "resp_result",
                          "result",
                          "products",
                          "product",
                          0)

        return {} if result.nil?

        {
          "promotion_link" => result["promotion_link"],
          "product_main_image_url" => result["product_main_image_url"]
        }
      end

      def build_params
        params = {
          "method" => "aliexpress.affiliate.product.query",
          "keywords" => keywords,
          "ship_to_country" => ship_to_country,
          "page_size" => 1,
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
