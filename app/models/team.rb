class Team < ApplicationRecord
  belongs_to :recipient
  has_many :team_members, dependent: :destroy

  validates :recipient_id, uniqueness: true
  validates :name, length: { maximum: 50 }

  def name
    super.presence || recipient.name
  end
end
