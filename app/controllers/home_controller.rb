class HomeController < ApplicationController
  def about
    authorize :home
  end

  def calendar
    authorize :home

    respond_to do |format|
      format.html { render "home/calendar" }
      format.turbo_stream do
        recipients = load_recipients
        render "home/calendar", locals: { recipients:, teams: load_teams(recipients) }, layout: false
      end
      format.json do
        render json: load_recipients, each_serializer: RecipientSerializer
      end
    end
  end

  private

  def load_recipients
    policy_scope(Recipient).where(event_date: params[:start]..params[:end])
                           .order(id: :desc)
  end

  def load_teams(recipients)
    policy_scope(Team).where(recipient: recipients)
  end
end
