class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :trackable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :recipients, dependent: :destroy, foreign_key: :creator_id

  enum :role, { user: 0, admin: 1 }, suffix: true

  validate :email_not_taken_by_google_user, on: :create

  def self.from_omniauth(auth)
    find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.confirmed_at = Time.zone.now
    end
  end

  # TODO: fix devise deliver_later
  # def send_devise_notification(notification, *args)
  #   if new_record? || changed?
  #     pending_notifications << [notification, args]
  #   else
  #     devise_mailer.send(notification, self, *args).deliver_later(queue: :mailers)
  #   end
  # end

  private

  def email_not_taken_by_google_user
    user = User.find_by(email:)

    if user&.provider == 'google_oauth2'
      errors.add(:base, "The account is linked to a Google account. Please sign in with Google")
    end
  end
end
