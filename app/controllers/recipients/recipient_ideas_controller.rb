module Recipients
  class RecipientIdeasController < ApplicationController
    def destroy
      recipient = find_recipient
      recipient_idea = find_recipient_idea(recipient)
      authorize(recipient_idea)

      if recipient_idea.destroy
        idea_ids = recipient.ideas.order('recipient_ideas.priority ASC').ids
        RecipientIdeas::ReorderService.new(recipient, idea_ids).call

        idea = recipient_idea.idea

        render 'recipients/recipient_ideas/destroy', locals: { recipient:, idea: }
      end
    end

    def reorder
      authorize(RecipientIdea)

      recipient = find_recipient
      idea_ids = params.require(:idea_ids).map(&:to_i)

      RecipientIdeas::ReorderService.new(recipient, idea_ids).call
    end

    private

    def find_recipient
      policy_scope(Recipient).find(params[:recipient_id])
    end

    def find_recipient_idea(recipient)
      policy_scope(recipient.recipient_ideas).find(params[:id])
    end
  end
end
