class TeamMembersController < ApplicationController
  def destroy
    team_member = find_team_member
    authorize(team_member)

    team = team_member.team

    if team_member.destroy
      team.decrement_members_count!

      flash[:notice] = "Deleted successfully"
    else
      flash[:warning] = team_member.errors.full_messages.to_sentence
    end

    render "team_members/destroy", locals: { team_member: }
  end

  private

  def find_team_member
    policy_scope(TeamMember).find(params[:id])
  end
end
