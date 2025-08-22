class TeamMember < ApplicationRecord
  belongs_to :team
  belongs_to :user

  has_one :recipient, through: :team

  validates :user_id, uniqueness: { scope: :team_id }
end
