class Team < ApplicationRecord
  belongs_to :recipient
  has_many :team_members, dependent: :destroy

  before_validation :generate_invitation_token, on: :create

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

  private

  def generate_invitation_token
    return if invitation_token.present?

    loop do
      random_token = SecureRandom.hex(32)

      unless Team.exists?(invitation_token: random_token)
        self.invitation_token = random_token
        break
      end
    end
  end
end
