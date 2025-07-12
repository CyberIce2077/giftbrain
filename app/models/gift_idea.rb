class GiftIdea < ApplicationRecord
  has_many :gift_target_gift_ideas, dependent: :destroy
  has_many :gift_targets, through: :gift_target_gift_ideas

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :description, presence: true
end
