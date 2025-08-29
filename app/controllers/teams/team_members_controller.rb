module Teams
  class TeamMembersController < ApplicationController
    def new
      team = find_team
      team_member = team.team_members.build
      authorize(team_member)

      render "teams/team_members/new", locals: { team:, team_member: }
    end

    def create
      team = find_team
      user = User.find_by(email: team_member_params[:email])
      team_member = team.team_members.build(user:)
      authorize(team_member)

      if team_member.save
        flash[:notice] = "Created successfully"

        redirect_to [team_member.team]
      else
        flash[:warning] = team_member.errors.full_messages.to_sentence

        render "teams/team_members/new", locals: { team:, team_member: }
      end
    end

    private

    def find_team
      policy_scope(Team).find(params[:team_id])
    end

    def team_member_params
      params.require(:team_member).permit(team_member_attrs)
    end

    def team_member_attrs
      %i[email]
    end
  end
end
