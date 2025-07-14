module Recipients
  class RecipientIdeasController < ApplicationController
    def destroy
      recipient = find_recipient
      recipient_idea = find_recipient_idea(recipient)
      idea = recipient_idea.idea

      recipient_idea.destroy

      render 'recipients/recipient_ideas/destroy', locals: { idea: }
    end

    def reorder
      recipient = find_recipient

      ordered_ids = params.require(:ordered_ids).map(&:to_i)

      raise "Not same count" if ordered_ids.size != recipient.ideas.size

      recipient_ideas = RecipientIdea.where(recipient:, idea: ordered_ids)

      ActiveRecord::Base.transaction do
        ordered_ids.each_with_index do |id, index|
          recipient_idea = recipient_ideas.find { |r| r.idea_id == id }
          recipient_idea.update!(priority: index + 1)
        end
      end
    end

    private

    def find_recipient
      Recipient.find(params[:recipient_id])
    end

    def find_recipient_idea(recipient)
      recipient.recipient_ideas.find(params[:id])
    end
  end
end
