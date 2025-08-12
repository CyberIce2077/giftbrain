module Users
  class UpdateEventStatsService < BaseService
    attr_reader :user

    def initialize(user)
      super
      @user = user
    end

    def call
      start_date = Time.zone.now

      recipients = Pundit.policy_scope(user, Recipient)

      event_stats = {
        events_1m_count: recipients.where(event_date: start_date..(start_date + 1.month)).count,
        events_3m_count: recipients.where(event_date: start_date..(start_date + 3.months)).count,
        events_6m_count: recipients.where(event_date: start_date..(start_date + 6.months)).count
      }

      user.update!(event_stats:)

      success!
    rescue StandardError => e
      errors.add(:base, e.message)
      log_error(e)
    end
  end
end
