module GiftIdeas
  class CreateService < BaseService
    attr_reader :gift_target, :gift_ideas

    def initialize(gift_target, gift_ideas)
      super
      @gift_target = gift_target
      @gift_ideas = gift_ideas
    end

    def call
      gift_ideas.each do |gift_idea|
        gift_target.gift_ideas.create!(gift_idea)
      rescue ActiveRecord::RecordInvalid
        next
      end
    rescue StandardError
      errors.add(:base, 'Something went wrong')
    end
  end
end
