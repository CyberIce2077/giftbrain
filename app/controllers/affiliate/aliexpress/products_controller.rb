module Affiliate
  module Aliexpress
    class ProductsController < ApplicationController
      def index
        skip_policy_scope
        authorize(:product)

        recipient_idea = find_recipient_idea
        recipient = recipient_idea.recipient

        service = list_service.new(keywords: recipient_idea.name, ship_to_country: recipient.ship_to_country, page_no: params[:page] || 1)
        service.call

        products = ::Affiliate::Aliexpress::Product.build_from_collection(service.data[:products])
        products = Kaminari.paginate_array(products, total_count: service.data[:total_count])
                           .page(params[:page])

        render "affiliate/aliexpress/products/index", locals: { recipient:, products: }
      end

      private

      def find_recipient_idea
        policy_scope(RecipientIdea).find(params[:recipient_idea_id])
      end

      def list_service
        ::Affiliate::Aliexpress::Products::ListService
      end
    end
  end
end
