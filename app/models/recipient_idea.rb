class RecipientIdea < ApplicationRecord
  belongs_to :recipient, counter_cache: true
  belongs_to :idea

  delegate :name, to: :idea

  validates :priority, presence: true
  validates :recipient_id, uniqueness: { scope: :idea_id }
end
