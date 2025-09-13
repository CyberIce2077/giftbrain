module Affiliate
  module Aliexpress
    class ProductsController < ApplicationController
      def index
        skip_policy_scope
        authorize(:product)

        recipient_idea = find_recipient_idea
        recipient = recipient_idea.recipient
        favorite_products = recipient.favorite_products

        service = list_service.new(recipient_idea, params[:page] || 1)
        service.call

        products = ::Affiliate::Aliexpress::Product.build_from_collection(service.data[:products])
        products = Kaminari.paginate_array(products, total_count: service.data[:total_count])
                           .page(params[:page])

        render "affiliate/aliexpress/products/index", locals: { recipient_idea:, recipient:, products:, favorite_products: }
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
