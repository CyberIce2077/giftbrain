module GiftTargets
  class GiftIdeasController < ApplicationController
    def destroy
      gift_target = find_gift_target
      gift_idea = find_gift_idea(gift_target)

      gift_target_gift_idea = GiftTargetGiftIdea.find_by(gift_target:, gift_idea:)

      if gift_target_gift_idea.destroy
        render 'gift_targets/gift_ideas/destroy', locals: { gift_idea: }
      end
    end

    private

    def find_gift_target
      GiftTarget.find(params[:gift_target_id])
    end

    def find_gift_idea(gift_target)
      gift_target.gift_ideas.find(params[:id])
    end
  end
end
