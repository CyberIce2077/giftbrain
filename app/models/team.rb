class Team < ApplicationRecord
  belongs_to :recipient
  has_many :team_members, dependent: :destroy

  validates :recipient_id, uniqueness: true
  validates :name, length: { maximum: 50 }

  def name
    super.presence || recipient.name
  end

  # TODO: extract to concern
  def increment_members_count!
    update!(members_count: members_count + 1)
  end

  def decrement_members_count!
    update!(members_count: members_count - 1) if members_count > 0
  end

  def reset_members_count!
    update!(members_count: recipient_ideas.count)
  end
end
