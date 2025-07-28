class Recipient < ApplicationRecord
  belongs_to :creator, class_name: "User"

  has_many :recipient_ideas, dependent: :destroy
  has_many :ideas, through: :recipient_ideas

  validates :name, :description, presence: true

  enum :status, { draft: 0, pending: 1, processing: 2, finishing: 3, success: 4, failed: 5 }, suffix: true

  def editable?
    draft_status? || failed_status? || success_status?
  end

  def increment_ideas_count!
    update!(ideas_count: ideas_count + 1)
  end

  def decrement_ideas_count!
    update!(ideas_count: ideas_count - 1) if ideas_count > 0
  end

  def reset_ideas_count!
    update!(ideas_count: recipient_ideas.count)
  end
end
