module RecipientIdeas
  class ReorderService < BaseService
    attr_reader :recipient, :idea_ids

    class NotSameCountError < StandardError; end

    def initialize(recipient, idea_ids)
      super
      @recipient = recipient
      @idea_ids = idea_ids
    end

    def call
      recipient_ideas = recipient.recipient_ideas

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
  end
end
