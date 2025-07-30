module Users
  class SessionsController < Devise::SessionsController
    def create
      user = User.find_by(email: params[:user][:email])

      if user&.provider == 'google_oauth2'
        flash[:warning] = 'The account is linked to a Google account. Please sign in with Google.'
        redirect_to new_user_session_path and return
      end

      super
    end
  end
end
