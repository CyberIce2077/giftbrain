class Idea < ApplicationRecord
  MAX_IDEA_COUNT = 20

  before_validation :strip_whitespace

  has_many :recipient_ideas, dependent: :destroy
  has_many :recipients, through: :recipient_ideas

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  private

  def strip_whitespace
    self.name = name.to_s.strip
  end
end
