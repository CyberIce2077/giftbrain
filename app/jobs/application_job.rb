class ApplicationJob < ActiveJob::Base
  # sidekiq_options retry: false

  # Automatically retry jobs that encountered a deadlock
  # retry_on ActiveRecord::Deadlocked

  # Most jobs are safe to ignore if the underlying records are no longer available
  # discard_on ActiveJob::DeserializationError

  class UnsuccessfulServiceError < StandardError; end
  class MissingBlockError < StandardError; end

  def perform
    raise MissingBlockError unless block_given?

    service = yield.new
    service.call

    validate_successful_service!(service)
  end

  private

  def validate_successful_service!(service)
    return if service.success?

    raise UnsuccessfulServiceError, service.errors.full_messages.to_sentence
  end
end
