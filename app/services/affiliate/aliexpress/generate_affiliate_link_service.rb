module Affiliate
  module Aliexpress
    class GenerateAffiliateLinkService < BaseService
      class PromotionLinkError < StandardError; end

      URL = "https://api-sg.aliexpress.com/sync".freeze

      attr_reader :keywords

      def initialize(keywords)
        super
        @keywords = keywords
      end

      def call
        response = HTTP.get("#{URL}?#{URI.encode_www_form(build_params)}")

        promotion_link = parse_response(response).dig(0, "promotion_link")

        validate_promotion_link!(promotion_link)

        @data = promotion_link

        success!
      rescue StandardError => e
        errors.add(:base, e.message)
        log_error(e)
      end

      private

      def validate_promotion_link!(promotion_link)
        raise PromotionLinkError, "Promotion link is missing" if promotion_link.blank?

        unless promotion_link.start_with?("https://s.click.aliexpress.com")
          raise PromotionLinkError, "Promotion link is invalid"
        end
      end

      def parse_response(response)
        JSON.parse(response.body.to_s).dig("aliexpress_affiliate_product_query_response",
                                           "resp_result",
                                           "result",
                                           "products",
                                           "product")
      end

      def build_params
        params = {
          "method" => "aliexpress.affiliate.product.query",
          "keywords" => keywords,
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
