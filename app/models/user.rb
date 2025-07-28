class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  has_many :recipients, dependent: :destroy, foreign_key: :creator_id

  # def send_devise_notification(notification, *args)
  #   sleep 1 # Simulate a delay for the email to be sent
  #   devise_mailer.send(notification, self, *args).deliver_later(queue: :mailers, attempts: 5)
  # end
end
