module GiftTargets
  module GiftIdeas
    class GiftTargetGiftIdeasController < ApplicationController
      def reorder
        gift_target = find_gift_target
        moved_gift_idea = gift_target.gift_ideas.find(params[:gift_idea_id])
        target_gift_idea = gift_target.gift_ideas.find(params[:target_id])

        moved_gift_target_gift_idea = GiftTargetGiftIdea.find_by(gift_target:, gift_idea: moved_gift_idea)
        target_gift_target_gift_idea = GiftTargetGiftIdea.find_by(gift_target:, gift_idea: target_gift_idea)

        moved_priority = moved_gift_target_gift_idea.priority
        target_priority = target_gift_target_gift_idea.priority

        moved_gift_target_gift_idea.update!(priority: target_priority)
        target_gift_target_gift_idea.update!(priority: moved_priority)
      end

      private

      def find_gift_target
        GiftTarget.find(params[:gift_target_id])
      end

      def find_gift_idea(gift_target)
        gift_target.gift_ideas.find(params[:gift_idea_id])
      end
    end
  end
end
