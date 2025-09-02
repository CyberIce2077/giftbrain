class HomeController < ApplicationController
  before_action :authenticate_user!, except: %i[about]

  def about
    authorize :home
  end

  def calendar
    authorize :home

    date = params.fetch(:date, Time.zone.now).to_date

    recipients =
      policy_scope(Recipient).where(event_date: date.beginning_of_month..date.end_of_month)
    teams = policy_scope(Team).where(recipient: recipients)

    render "home/calendar", locals: { date:, recipients:, teams: }
  end
end
