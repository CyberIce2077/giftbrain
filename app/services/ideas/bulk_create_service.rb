module Ideas
  class BulkCreateService < BaseService
    attr_reader :recipient, :json_ideas, :ideas

    def initialize(recipient, json_ideas)
      super
      @recipient = recipient
      @json_ideas = json_ideas
      @ideas = []
    end

    def call
      json_ideas.each do |json_idea|
        idea = Idea.create_with(description: json_idea["description"])
                   .find_or_create_by(name: json_idea["name"])

        RecipientIdea.create!(idea:, recipient:)
      rescue ActiveRecord::RecordInvalid
        next
      end

      ideas = recipient.ideas.order('recipient_ideas.priority ASC')
      reorder_service = RecipientIdeas::ReorderService.new(recipient, ideas.ids)
      reorder_service.call

      recipient.reset_ideas_count!

      @ideas = ideas
      success!
    rescue StandardError
      errors.add(:base, 'Something went wrong')
    end
  end
end
