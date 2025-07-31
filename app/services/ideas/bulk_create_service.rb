module Ideas
  class BulkCreateService < BaseService
    attr_reader :recipient, :data

    def initialize(recipient, data)
      super
      @recipient = recipient
      @data = data
    end

    def call
      data.each do |json_idea|
        idea = Idea.create_with(description: json_idea["description"])
                   .find_or_create_by(name: json_idea["name"])

        RecipientIdea.create!(recipient:, idea:)

        update_ideas_view(idea)
      rescue ActiveRecord::RecordInvalid
        next
      end

      ideas = recipient.ideas.order('recipient_ideas.priority ASC')
      reorder_service = RecipientIdeas::ReorderService.new(recipient, ideas.ids)
      reorder_service.call

      recipient.reset_ideas_count!

      success!
    rescue StandardError => e
      errors.add(:base, e.message)
      log_error(e)
    end

    private

    def update_ideas_view(idea)
      idea.broadcast_prepend_to(
        recipient,
        target: 'ideas',
        partial: "/recipients/idea",
        locals: { idea:, recipient: }
      )
    end
  end
end
