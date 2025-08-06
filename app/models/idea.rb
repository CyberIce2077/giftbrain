class Idea < ApplicationRecord
  MAX_IDEA_COUNT = 20

  has_many :recipient_ideas, dependent: :destroy
  has_many :recipients, through: :recipient_ideas

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :description, presence: true
end
