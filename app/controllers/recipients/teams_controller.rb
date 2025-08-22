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

      if team.save
        flash[:notice] = "Created successfully"

        redirect_to [team]
      else
        flash[:warning] = team.errors.full_messages.to_sentence

        render "recipients/teams/new", locals: { team: }
      end
    end

    def edit
      team = find_team
      authorize(team)

      render "recipients/teams/edit", locals: { team: }
    end

    def update
      team = find_team
      authorize(team)

      if team.update(team_params)
        flash[:notice] = "Updated successfully"

        redirect_to [team]
      else
        flash[:warning] = team.errors.full_messages.to_sentence

        render "recipients/teams/edit", locals: { team: }
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

    def find_recipient
      policy_scope(Recipient).find(params[:recipient_id])
    end

    def find_team
      policy_scope(Team).find(params[:id])
    end

    def team_params
      params.require(:team).permit(team_attrs)
    end

    def team_attrs
      %i[name recipient_id]
    end
  end
end
