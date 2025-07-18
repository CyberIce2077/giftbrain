class Recipient < ApplicationRecord
  belongs_to :creator, class_name: "User"

  has_many :recipient_ideas, dependent: :destroy
  has_many :ideas, through: :recipient_ideas

  validates :name, :description, presence: true

  enum :status, { draft: 0, pending: 1, processing: 2, success: 3, failed: 4 }, suffix: true

  def editable?
    draft_status? || failed_status? || success_status?
  end
end
