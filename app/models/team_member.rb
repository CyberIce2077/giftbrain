class TeamMember < ApplicationRecord
  belongs_to :team
  belongs_to :user

  has_one :recipient, through: :team
  delegate :creator, to: :recipient

  enum :status, { pending: 0, accepted: 1, declined: 2 }, suffix: true

  validates :user_id, uniqueness: { scope: :team_id }

  def permitted_to_destroy?(current_user)
    return if user == creator

    current_user == creator
  end
end
