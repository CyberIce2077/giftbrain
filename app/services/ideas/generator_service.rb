module Ideas
  class GeneratorService < BaseService
    class GenerationError < StandardError; end
    class MissingBlockError < StandardError; end

    AI_SERVICES = [
      Ai::External::OpenAi::Gpt4oService,
      Ai::Local::Phi4MiniService
    ].freeze

    attr_reader :recipient

    def initialize(recipient)
      super
      @recipient = recipient
      @data = {}
    end

    def call
      update_recipient(:processing)

      AI_SERVICES.each do |ai_service|
        break if ai_request { ai_service }
      end

      raise GenerationError, "Data is empty" if @data.empty?

      update_recipient(:finishing)

      create_service = Ideas::BulkCreateService.new(recipient, @data)
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

    def ai_request
      raise MissingBlockError unless block_given?

      service = yield.new(recipient)
      service.call

      @data = service.data
      service.success?
    end

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
