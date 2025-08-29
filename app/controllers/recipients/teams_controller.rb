module Recipients
  class TeamsController < ApplicationController
    def new
      recipient = find_recipient
      team = Team.new(recipient:)
      authorize(team)

      render "recipients/teams/new", locals: { team:, recipient: }
    end

    def create
      recipient = find_recipient
      team = Team.new(team_params.merge(recipient:))
      authorize(team)

      team.team_members.build(user: current_user, status: :accepted)

      if team.save
        flash[:notice] = "Created successfully"

        redirect_to [team]
      else
        flash[:warning] = team.errors.full_messages.to_sentence

        render "recipients/teams/new", locals: { team:, recipient: }
      end
    end

    def edit
      recipient = find_recipient
      team = recipient.team
      authorize(team)

      render "recipients/teams/edit", locals: { team:, recipient: }
    end

    def update
      recipient = find_recipient
      team = recipient.team
      authorize(team)

      if team.update(team_params)
        flash[:notice] = "Updated successfully"

        redirect_to [team]
      else
        flash[:warning] = team.errors.full_messages.to_sentence

        render "recipients/teams/edit", locals: { team:, recipient: }
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
      %i[name]
    end
  end
end
