class ApplicationMailer < ActionMailer::Base
  append_view_path Rails.root.join('app', 'views', 'mailers')
  default from: "noreply@giftbrain.app"
  layout "mailer"
end
