class Team < ApplicationRecord
  belongs_to :recipient
  has_many :team_members, dependent: :destroy
  delegate :creator, to: :recipient

  before_validation :generate_public_token, on: :create

  validates :recipient_id, uniqueness: true
  validates :name, length: { maximum: 50 }
  validates :public_token, presence: true

  scope :public_join, -> { where(public_join: true) }

  def name
    super.presence || recipient.name
  end

  private

  def generate_public_token
    return if public_token.present?

    loop do
      random_token = SecureRandom.hex(32)

      unless Team.exists?(public_token: random_token)
        self.public_token = random_token
        break
      end
    end
  end
end
