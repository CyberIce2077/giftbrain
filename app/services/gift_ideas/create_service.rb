module GiftIdeas
  class CreateService < BaseService
    attr_reader :gift_ideas, :gift_target

    def initialize(gift_ideas, gift_target)
      super
      @gift_ideas = gift_ideas
      @gift_target = gift_target
    end

    def call
      gift_ideas.each do |gift_idea|
        gift_target.gift_ideas.create(gift_idea)
      end
    end
  end
end
