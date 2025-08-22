class TeamsController < ApplicationController
  def index
    authorize(Team)

    teams = policy_scope(Team).order(id: :desc)

    render "teams/index", locals: { teams: }
  end

  def show
    team = find_team
    authorize(team)

    team_members = policy_scope(team.team_members).order(id: :desc)

    render "teams/show", locals: { team:, team_members: }
  end

  def edit
    team = find_team
    authorize(team)

    render "teams/edit", locals: { team: }
  end

  def update
    team = find_team
    authorize(team)

    if team.update(team_params)
      flash[:notice] = "Updated successfully"

      redirect_to [team]
    else
      flash[:warning] = team.errors.full_messages.to_sentence

      render "teams/edit", locals: { team: }
    end
  end

  def destroy
    team = find_team
    authorize(team)

    if team.destroy
      flash[:notice] = "Deleted successfully"

      redirect_to [:teams]
    else
      flash[:warning] = team.errors.full_messages.to_sentence

      redirect_to [team]
    end
  end

  private

  def find_team
    policy_scope(Team).find(params[:id])
  end

  def team_params
    params.require(:team).permit(team_attrs)
  end

  def team_attrs
    %i[name]
  end
end
