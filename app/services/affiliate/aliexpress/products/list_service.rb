module Affiliate
  module Aliexpress
    module Products
      class ListService < BaseService
        class ApiError < StandardError; end
        class EmptyResultError < StandardError; end

        attr_reader :recipient_idea, :page_no

        def initialize(recipient_idea, page_no = 1)
          super
          @recipient_idea = recipient_idea
          @page_no = page_no
          @data = { products: [], total_count: 0 }
        end

        def call
          @data = Rails.cache.fetch(cache_key, expires_in: 30.minutes) do
            result = client.get(build_params).body
            validate_result!(result)

            result = result.dig("aliexpress_affiliate_product_query_response", "resp_result", "result")

            products = result.dig("products", "product").presence || []
            total_count = result.dig("total_record_count").to_i

            { products:, total_count: }
          rescue EmptyResultError
            { products: [], total_count: 0 }
          end

          validate_data_presence!
          success!
        rescue StandardError => e
          errors.add(:base, e.message)
          log_error(e)
        end

        private

        def validate_result!(result)
          raise ApiError, "Empty API response" unless result.is_a?(Hash)

          if result.dig("aliexpress_affiliate_product_query_response", "resp_result", "resp_msg") == "The result is empty"
            raise EmptyResultError, "No products found"
          end

          if result.dig("aliexpress_affiliate_product_query_response", "resp_result", "result", "products", "product").blank?
            raise ApiError, "Invalid API response"
          end
        end

        def build_params
          {
            "method" => "aliexpress.affiliate.product.query",
            "target_currency" => "USD",
            "keywords" => recipient_idea.name,
            "ship_to_country" => recipient_idea.ship_to_country,
            "page_no" => page_no,
            "page_size" => 50
          }
        end

        def cache_key
          [
            "affiliate_aliexpress_products",
            recipient_idea.name.downcase.tr(" ", "_"),
            recipient_idea.ship_to_country,
            page_no
          ].join(":")
        end

        def client
          ::Affiliate::AliexpressClient.new
        end
      end
    end
  end
end
