module GiftIdeas
  class CreateService < BaseService
    attr_reader :recipient, :json_ideas

    def initialize(recipient, json_ideas)
      super
      @recipient = recipient
      @json_ideas = json_ideas
    end

    def call
      priority = 1

      json_ideas.each do |json_idea|
        ActiveRecord::Base.transaction do
          idea = Idea.new(json_idea)
          idea.save!

          recipient_idea = RecipientIdea.new(idea:, recipient:, priority:)
          recipient_idea.save!

          priority += 1
        end
      rescue ActiveRecord::RecordInvalid
        next
      end
    rescue StandardError
      errors.add(:base, 'Something went wrong')
    end
  end
end
