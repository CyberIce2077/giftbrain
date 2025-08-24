class Team < ApplicationRecord
  belongs_to :recipient
  has_many :team_members, dependent: :destroy

  before_validation :generate_invitation_token, on: :create

  validates :recipient_id, uniqueness: true
  validates :name, length: { maximum: 50 }

  def name
    super.presence || recipient.name
  end

  private

  def generate_invitation_token
    return if invitation_token.present?

    loop do
      random_token = SecureRandom.hex(16)

      unless Team.exists?(invitation_token: random_token)
        self.invitation_token = random_token
        break
      end
    end
  end
end
