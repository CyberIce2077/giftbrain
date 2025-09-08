module Users
  class UnsubscribeController < ApplicationController
    rate_limit to: 10, within: 3.minutes

    skip_before_action :authenticate_user!
    skip_after_action :verify_authorized
    skip_after_action :verify_policy_scoped

    def edit
      sign_out(current_user) if current_user

      user = User.subscribed.find_by!(unsubscribe_token: params[:unsubscribe_token])

      render "users/unsubscribe/edit", locals: { user: }
    end

    def update
      User.subscribed
          .find_by!(unsubscribe_token: params[:unsubscribe_token])
          .update!(subscribed: false)

      flash[:notice] = "Unsubscribed from all events!"

      redirect_to root_path
    end
  end
end
