module Recipients
  class RecipientIdeasController < ApplicationController
    def destroy
      recipient = find_recipient
      recipient_idea = recipient.recipient_ideas.find(params[:id])
      idea = recipient_idea.idea

      if recipient_idea.destroy
        idea_ids = recipient.ideas.ids
        RecipientIdeas::ReorderService.new(recipient, idea_ids).call

        render 'recipients/recipient_ideas/destroy', locals: { idea: }
      end
    end

    def reorder
      recipient = find_recipient
      idea_ids = params.require(:idea_ids).map(&:to_i)

      RecipientIdeas::ReorderService.new(recipient, idea_ids).call
    end

    private

    def find_recipient
      Recipient.find(params[:recipient_id])
    end
  end
end
