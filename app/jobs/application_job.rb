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

    service = yield

    service = service.new if service.is_a?(Class)
    service.call

    raise UnsuccessfulServiceError unless service.success?
  end
end
