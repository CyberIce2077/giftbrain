class RecipientIdeasController < ApplicationController
  def destroy
    recipient_idea = find_recipient_idea
    authorize(recipient_idea)

    recipient = recipient_idea.recipient
    idea = recipient_idea.idea

    # if recipient_idea.destroy
    #   idea_ids = policy_scope(recipient.ideas).order('recipient_ideas.priority ASC').ids
    #   RecipientIdeas::ReorderService.new(recipient, idea_ids).call

    #   recipient.decrement_ideas_count!

    #   flash[:notice] = 'Idea removed successfully'
    # else
    #   flasj[:warning] = recipient_idea.errors.full_messages.to_sentence
    # end

    render 'recipients/recipient_ideas/destroy', locals: { recipient:, idea: }
  end

  def reorder
    authorize(RecipientIdea)

    recipient = policy_scope(Recipient).find(reorder_params[:recipient_id])
    idea_ids = reorder_params[:idea_ids].map(&:to_i)

    RecipientIdeas::ReorderService.new(recipient, idea_ids).call
  end

  private

  def find_recipient_idea
    policy_scope(RecipientIdea).find(params[:id])
  end

  def reorder_params
    params.require(:reorder).permit(:recipient_id, idea_ids: [])
  end
end
