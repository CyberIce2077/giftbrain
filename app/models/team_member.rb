class TeamMember < ApplicationRecord
  belongs_to :team, counter_cache: true
  belongs_to :user

  has_one :recipient, through: :team

  enum :status, { pending: 0, accepted: 1, declined: 2 }, suffix: true

  validates :user_id, uniqueness: { scope: :team_id }
end
