class GiftTarget < ApplicationRecord
  belongs_to :user
  has_many :gift_target_gift_ideas, dependent: :destroy
  has_many :gift_ideas, through: :gift_target_gift_ideas

  validates :name, :description, presence: true
end
