module Recipients
  class RecipientIdeasController < ApplicationController
    def destroy
      recipient = find_recipient
      recipient_idea = find_recipient_idea(recipient)
      authorize(recipient_idea)

      idea = recipient_idea.idea

      if recipient_idea.destroy
        idea_ids = policy_scope(recipient.ideas).order('recipient_ideas.priority ASC').ids
        RecipientIdeas::ReorderService.new(recipient, idea_ids).call

        recipient.decrement_ideas_count!

        flash[:notice] = 'Idea removed successfully'
      else
        flasj[:warning] = recipient_idea.errors.full_messages.to_sentence
      end

      render 'recipients/recipient_ideas/destroy', locals: { recipient:, idea: }
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
