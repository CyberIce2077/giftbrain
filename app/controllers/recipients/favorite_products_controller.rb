module Recipients
  class FavoriteProductsController < ApplicationController
    rate_limit to: 30, within: 3.minutes, only: %i[create destroy] if Rails.env.production?

    def create
      recipient = find_recipient
      favorite_product = recipient.favorite_products.build(favorite_product_params)
      authorize(favorite_product)

      if favorite_product.save
        flash[:notice] = "Added to favorites"
      else
        flash[:danger] = "Failed to add product to favorites"
      end

      render "recipients/favorite_products/create", locals: { recipient:, favorite_product: }
    end

    def destroy
      recipient = find_recipient
      favorite_product = recipient.favorite_products.find(params[:id])
      authorize(favorite_product)

      if favorite_product.destroy
        flash[:warning] = "Removed from favorites"
      else
        flash[:danger] = "Failed to remove product from favorites"
      end

      render "recipients/favorite_products/destroy", locals: { recipient:, favorite_product: }
    end

    private

    def find_recipient
      policy_scope(Recipient).find(params[:recipient_id])
    end

    def favorite_product_params
      params.require(:favorite_product).permit(favorite_product_attrs)
    end

    def favorite_product_attrs
      %i[product_id provider name promotion_link image original_price sale_price discount]
    end
  end
end
