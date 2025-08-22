class TeamsController < ApplicationController
  def index
    authorize(Team)

    teams = policy_scope(Team)

    render "teams/index", locals: { teams: }
  end

  def show
    team = find_team
    authorize(team)

    render "teams/show", locals: { team: }
  end

  private

  def find_team
    policy_scope(Team).find(params[:id])
  end
end
