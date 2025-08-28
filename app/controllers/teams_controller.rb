class TeamsController < ApplicationController
  def index
    authorize(Team)

    teams = policy_scope(Team).page(params[:page]).order(id: :desc)

    render "teams/index", locals: { teams: }
  end

  def show
    team = find_team
    authorize(team)

    team_members = policy_scope(team.team_members).where
                                                  .not(user: team.recipient.creator)
                                                  .page(params[:page])
                                                  .order(id: :desc)

    render "teams/show", locals: { team:, team_members: }
  end

  def destroy
    team = find_team
    authorize(team)

    if team.destroy
      flash[:notice] = "Deleted successfully"

      redirect_to teams_url
    else
      flash[:warning] = team.errors.full_messages.to_sentence

      redirect_to [team]
    end
  end

  def invitations
    team = find_team
    authorize(team)

    render "teams/invitations", locals: { team: }
  rescue ActiveRecord::RecordNotFound
    skip_authorization
    flash[:warning] = "Incorrect link or you have declined the invitation"
    redirect_to [:teams]
  end

  def accept
    team = find_team
    authorize(team)

    policy_scope(team.team_members).find_by!(user: current_user).accepted_status!

    flash[:notice] = "You have joined the team!"

    redirect_to [team]
  end

  def decline
    team = find_team
    authorize(team)

    policy_scope(team.team_members).find_by!(user: current_user).declined_status!

    flash[:notice] = "You have declined the invitation"

    redirect_to [:teams]
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
