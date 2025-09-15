module Ideas
  class BulkCreateService < BaseService
    attr_reader :recipient, :names

    def initialize(recipient, names)
      super
      @recipient = recipient
      @names = names
    end

    def call
      names.each do |name|
        idea = Idea.find_or_create_by(name:)

        recipient_idea = RecipientIdea.create!(recipient:, idea:)
        update_ideas_view(idea, recipient_idea)
      rescue ActiveRecord::RecordInvalid
        next
      end

      ideas = recipient.ideas.order("recipient_ideas.priority ASC")
      reorder_service = RecipientIdeas::ReorderService.new(recipient, ideas.ids)
      reorder_service.call

      recipient.update_recipient_view(:success)

      success!
    rescue StandardError => e
      errors.add(:base, e.message)
      log_error(e)
    end

    private

    def update_ideas_view(idea, recipient_idea)
      idea.broadcast_prepend_to(
        recipient,
        target: "ideas",
        partial: "/recipients/idea",
        locals: { idea:, recipient:, recipient_ideas: [recipient_idea] }
      )
    end
  end
end
