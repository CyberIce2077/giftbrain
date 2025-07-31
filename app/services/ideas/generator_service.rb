module Ideas
  class GeneratorService < BaseService
    class GenerationError < StandardError; end

    attr_reader :recipient

    def initialize(recipient)
      super
      @recipient = recipient
    end

    def call
      update_recipient(:processing)

      ai_service = Ai::External::OpenAi::Gpt4oService.new(recipient)
      ai_service.call

      # ai_service = Ai::Local::Phi4MiniService.new(recipient)
      # ai_service.call

      unless ai_service.success?
        raise GenerationError, ai_service.errors.full_messages.to_sentence
      end

      update_recipient(:finishing)

      create_service = Ideas::BulkCreateService.new(recipient, ai_service.data)
      create_service.call

      unless create_service.success?
        raise GenerationError, create_service.errors.full_messages.to_sentence
      end

      update_recipient(:success)
      success!
    rescue StandardError => e
      errors.add(:base, e.message)
      log_error(e)
      update_recipient(:failed)
    end

    private

    def update_recipient(status)
      case status
      when :processing
        recipient.processing_status!
      when :finishing
        recipient.finishing_status!
      when :success
        recipient.success_status!
      when :failed
        recipient.failed_status!
      end

      update_recipient_view
    end

    def update_recipient_view
      recipient.broadcast_update_to(
        recipient,
        target: recipient,
        partial: "/recipients/recipient",
        locals: { recipient: }
      )
    end
  end
end
