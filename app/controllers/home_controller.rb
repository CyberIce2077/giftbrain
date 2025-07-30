class HomeController < ApplicationController
  def about
    authorize :home
  end

  def calendar
    authorize :home

    recipients = policy_scope(Recipient).where(event_date: params[:start]..params[:end])

    respond_to do |format|
      format.html { render 'home/calendar' }
      format.json do
      render json: recipients.map { |recipient|
          {
            id: recipient.id,
            title: recipient.name,
            start: recipient.event_date,
            url: Rails.application.routes.url_helpers.recipient_path(recipient)
          }
        }
      end
    end
  end
end
