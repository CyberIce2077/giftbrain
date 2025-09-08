class RecipientIdea < ApplicationRecord
  belongs_to :recipient, counter_cache: true
  belongs_to :idea

  delegate :name, to: :idea
  delegate :ship_to_country, to: :recipient

  validates :priority, presence: true
  validates :recipient_id, uniqueness: { scope: :idea_id }
end
