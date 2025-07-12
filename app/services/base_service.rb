class BaseService
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

  # def extra
  #   {}
  # end

  # private

  # def notify_error(error, extra: {})
  #   Sentry.capture_exception(error, extra:)
  # end
end
