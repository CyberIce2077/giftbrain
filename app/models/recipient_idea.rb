class RecipientIdea < ApplicationRecord
  belongs_to :recipient
  belongs_to :idea
end
