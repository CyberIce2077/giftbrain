module Recipients
  class TeamsController < ApplicationController
    def new
      recipient = find_recipient
      team = Team.new(recipient:)
      authorize(team)

      render "recipients/teams/new", locals: { team: }
    end

    def create
      team = Team.new(team_params)
      authorize(team)

      team.team_members.build(user: current_user)
      team.members_count = 1

      if team.save
        flash[:notice] = "Created successfully"

        redirect_to [team]
      else
        flash[:warning] = team.errors.full_messages.to_sentence

        render "recipients/teams/new", locals: { team: }
      end
    end

    private

    def find_recipient
      policy_scope(Recipient).find(params[:recipient_id])
    end

    def team_params
      params.require(:team).permit(team_attrs)
    end

    def team_attrs
      %i[name recipient_id]
    end
  end
end
