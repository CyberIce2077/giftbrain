module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def google_oauth2
      user = User.from_omniauth(request.env['omniauth.auth'])

      if user.persisted?
        flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Google'
        sign_in_and_redirect user, event: :authentication
      else
        flash[:warning] = I18n.t 'devise.omniauth_callbacks.failure',
                          kind: 'Google',
                          reason: user.errors.full_messages.to_sentence
        redirect_to new_user_registration_url
      end
    end
  end
end
