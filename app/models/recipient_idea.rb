class RecipientIdea < ApplicationRecord
  belongs_to :recipient
  belongs_to :idea

  validates :priority, presence: true
  validates :recipient_id, uniqueness: { scope: :idea_id }
end
