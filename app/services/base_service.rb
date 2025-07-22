class BaseService
  GENERAL_ERROR_MESSAGE = "Something went wrong!"

  def initialize(*attrs); end

  def call
    raise StandardError
  end

  def success
    @success ||= false
  end

  def errors
    @errors ||= ActiveModel::Errors.new(self)
  end

  def errors?
    !valid?
  end

  def valid?
    errors.blank?
  end

  def success?
    success && !errors?
  end

  def success!
    @success = true
  end

  private

  def general_error_message
    errors.add(:base, GENERAL_ERROR_MESSAGE)
  end

  def log_info(e)
    Rails.logger.info("[#{self.class.name}] #{e.message}")
  end

  def log_error(e)
    Rails.logger.error("[#{self.class.name}] #{e.message}")
  end

  # def notify_error(error, extra: {})
  #   Sentry.capture_exception(error, extra:)
  # end
end
