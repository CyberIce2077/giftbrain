class UnsubscribeController < ApplicationController
  skip_before_action :authenticate_user!
  skip_after_action :verify_authorized
  skip_after_action :verify_policy_scoped

  def index
    sign_out(current_user) if current_user
    render "unsubscribe/index"
  end

  def create
    User.find_by!(unsubscribe_token: params[:ut])
        .update!(subscribed: false)

    flash[:notice] = "Unsubscribed from all events!"

    redirect_to root_path
  end
end
