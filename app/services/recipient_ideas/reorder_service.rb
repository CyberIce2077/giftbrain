module RecipientIdeas
  class ReorderService < BaseService
    attr_reader :recipient, :idea_ids

    def initialize(recipient, idea_ids)
      super
      @recipient = recipient
      @idea_ids = idea_ids
    end

    def call
      raise "Not same count" if idea_ids.size != recipient.ideas.size

      recipient_ideas = RecipientIdea.where(recipient:, idea: idea_ids)

      ActiveRecord::Base.transaction do
        idea_ids.each_with_index do |id, index|
          recipient_idea = recipient_ideas.find { |r| r.idea_id == id }
          recipient_idea.update!(priority: index + 1)
        end
      end
    rescue StandardError
      errors.add(:base, 'Something went wrong')
    end
  end
end
