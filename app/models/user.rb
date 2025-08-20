class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :trackable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :omniauthable, omniauth_providers: [:google_oauth2]

  before_validation :generate_unsubscribe_token, on: :create

  has_many :recipients, dependent: :destroy, foreign_key: :creator_id

  enum :role, { user: 0, admin: 1 }, suffix: true

  validates :unsubscribe_token, presence: true
  validate :email_not_taken_by_google_user, on: :create

  scope :subscribed, -> { where(subscribed: true) }

  def self.from_omniauth(auth)
    find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.confirmed_at = Time.zone.now
    end
  end

  def send_devise_notification(notification, *args)
    # NOTE: Deliver later will only fail in development because of eager_load = false
    message = devise_mailer.send(notification, self, *args)

    if Rails.env.development?
      message.deliver_now
    else
      message.deliver_later(queue: :mailers)
    end
  end

  private

  def email_not_taken_by_google_user
    user = User.find_by(email:)

    if user&.provider == "google_oauth2"
      errors.add(:base, "The account is linked to a Google account. Please sign in with Google")
    end
  end

  def generate_unsubscribe_token
    return if unsubscribe_token.present?

    loop do
      random_token = SecureRandom.hex(32)

      unless User.exists?(unsubscribe_token: random_token)
        self.unsubscribe_token = random_token
        break
      end
    end
  end
end
