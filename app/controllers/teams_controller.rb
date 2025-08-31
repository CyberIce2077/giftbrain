class TeamsController < ApplicationController
  rate_limit to: 10, within: 3.minutes, only: :public_join

  def index
    authorize(Team)

    teams = policy_scope(Team).page(params[:page]).order(id: :desc)
    team_members = policy_scope(TeamMember).where(team_id: teams.map(&:id))

    render "teams/index", locals: { teams:, team_members: }
  end

  def show
    team = find_team
    authorize(team)

    team_members =
      policy_scope(team.team_members).page(params[:page]).order(id: :desc)

    recipient = team.recipient

    render "teams/show", locals: { team:, team_members:, recipient: }
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

  def public_join
    team = Team.public_join.find_by!(public_token: params[:id])
    authorize(team)

    team.team_members.create!(user: current_user)

    redirect_to [:invitations, team]
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
