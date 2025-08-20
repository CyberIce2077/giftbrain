class HomeController < ApplicationController
  def about
    authorize :home
  end

  def calendar
    authorize :home

    recipients = policy_scope(Recipient).where(event_date: params[:start]..params[:end])
                                        .order(id: :desc)

    respond_to do |format|
      format.html { render "home/calendar" }
      format.turbo_stream { render "home/calendar", locals: { recipients: }, layout: false }
      format.json { render json: recipients, each_serializer: RecipientSerializer }
    end
  end
end
