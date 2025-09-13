module Affiliate
  module Aliexpress
    class Product
      include ActiveModel::Model
      include ActiveModel::Attributes

      DATA_ATTRIBUTES = %i[
        product_id
        product_title
        promotion_link
        product_main_image_url
        target_sale_price
        target_original_price
        discount
      ].freeze

      DATA_ATTRIBUTES.each do |attr|
        attribute attr, :string
      end

      class << self
        def build_from_response(data)
          new.tap do |product|
            DATA_ATTRIBUTES.each do |attr|
              product.public_send("#{attr}=", data[attr.to_s])
            end
          end
        end

        def build_from_collection(data)
          data.map { |item| build_from_response(item) }
        end
      end

      def provider = "aliexpress"

      def discount?
        discount != "0%"
      end

      def build_favorite_products_params
        {
          product_id:,
          name: product_title,
          promotion_link:,
          image: product_main_image_url,
          original_price: target_original_price,
          sale_price: target_sale_price,
          discount:,
          provider:
        }
      end
    end
  end
end
