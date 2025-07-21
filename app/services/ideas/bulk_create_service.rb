module Ideas
  class BulkCreateService < BaseService
    attr_reader :recipient, :json_ideas, :ideas

    class BulkCreateError < StandardError; end

    def initialize(recipient, json_ideas)
      super
      @recipient = recipient
      @json_ideas = json_ideas
      @ideas = []
    end

    def call
      ideas = recipient.ideas.to_a

      ActiveRecord::Base.transaction do
        json_ideas.each do |json_idea|
          next if ideas.find { |idea| idea.name == json_idea["name"] }

          idea = Idea.find_or_initialize_by(name: json_idea["name"])

          if idea.new_record?
            idea.description = json_idea["description"]
            idea.save!
          end

          RecipientIdea.create!(idea:, recipient:)

          ideas.push(idea)
        rescue ActiveRecord::RecordInvalid
          next
        end

        idea_ids = recipient.ideas.order('recipient_ideas.priority ASC').ids
        reorder_service = RecipientIdeas::ReorderService.new(recipient, idea_ids)
        reorder_service.call

        raise BulkCreateError unless reorder_service.success?
      end

      @ideas = ideas
      success!
    rescue StandardError
      errors.add(:base, 'Something went wrong')
    end
  end
end
