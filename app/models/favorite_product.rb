class FavoriteProduct < ApplicationRecord
  belongs_to :recipient

  validates :product_id, :provider, :name, :promotion_link, :image, :original_price, presence: true
  validates :product_id, uniqueness: { scope: %i[recipient_id provider], message: "is already in favorites" }

  enum :provider, { aliexpress: 0 }, suffix: true
end
