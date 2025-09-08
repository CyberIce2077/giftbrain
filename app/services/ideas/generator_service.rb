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
    end

    def call
      recipient.update_recipient_view(:processing)

      AI_SERVICES.each do |ai_service|
        break if ai_request { ai_service }
      end

      validate_data_presence!

      recipient.update_recipient_view(:finishing)
      ::Ideas::BulkCreateJob.perform_later(recipient, @data)

      success!
    rescue StandardError => e
      errors.add(:base, e.message)
      log_error(e)
      recipient.update_recipient_view(:failed)
    end

    private

    def ai_request
      raise MissingBlockError unless block_given?

      service = yield.new(recipient)
      service.call

      @data = service.data
      service.success?
    end
  end
end
