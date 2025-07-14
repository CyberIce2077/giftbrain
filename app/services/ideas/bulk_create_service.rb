module Ideas
  class BulkCreateService < BaseService
    attr_reader :recipient, :json_ideas

    def initialize(recipient, json_ideas)
      super
      @recipient = recipient
      @json_ideas = json_ideas
    end

    def call
      Idea.destroy_all


      # idea_names = json_ideas.uniq { |json_idea| json_idea["name"] }.map { |a| a["name"] }
      idea_names = recipient.ideas.pluck(:name)

      json_ideas.each_with_index do |json_idea, index|
        ActiveRecord::Base.transaction do
          next if idea_names.include?(json_idea["name"])

          idea = Idea.find_or_initialize_by(name: json_idea["name"])

          if idea.new_record?
            idea.description = json_idea["description"]
            idea.save!
          end

          recipient_idea = RecipientIdea.new(idea:, recipient:, priority: index + 1)
          recipient_idea.save!

          idea_names.push(json_idea["name"])
        end
      # rescue ActiveRecord::RecordInvalid
      #   next
      end

      idea_ids = recipient.ideas.ids
      RecipientIdeas::ReorderService.new(recipient, idea_ids).call
    # rescue StandardError
    #   errors.add(:base, 'Something went wrong')
    end
  end
end
