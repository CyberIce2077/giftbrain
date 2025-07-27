module RecipientIdeas
  class ReorderService < BaseService
    attr_reader :recipient, :idea_ids

    class ReorderError < StandardError; end

    def initialize(recipient, idea_ids)
      super
      @recipient = recipient
      @idea_ids = idea_ids
    end

    def call
      validate_idea_ids!

      recipient_ideas = RecipientIdea.where(recipient:)

      raise NotSameCountError if idea_ids.size != recipient_ideas.size

      ActiveRecord::Base.transaction do
        idea_ids.each_with_index do |id, index|
          recipient_idea = recipient_ideas.find { |r| r.idea_id == id }
          recipient_idea.update!(priority: index + 1)
        end
      end

      success!
    rescue StandardError => e
      general_error_message
      log_error(e)
    end

    private

    def validate_idea_ids!
      return if idea_ids.all? { |id| id.is_a?(Integer) } && idea_ids.size == recipient.recipient_ideas.size

      raise ReorderError, "Invalid idea_ids"
    end
  end
end
