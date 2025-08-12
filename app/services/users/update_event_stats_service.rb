module Users
  class UpdateEventStatsService < BaseService
    attr_reader :start_date, :users

    def initialize(users = User)
      super
      @start_date = Time.zone.now.beginning_of_month
      @users = users
    end

    def call
      users.find_each do |user|
        recipients = Pundit.policy_scope(user, Recipient)

        user.update(event_stats: build_event_stats(recipients))
      end

      success!
    rescue StandardError => e
      errors.add(:base, e.message)
      log_error(e)
    end

    private

    def build_event_stats(recipients)
      {
        events_1m_count: count_recipients(recipients, 1.month),
        events_3m_count: count_recipients(recipients, 3.months),
        events_6m_count: count_recipients(recipients, 6.months)
      }
    end

    def count_recipients(recipients, offset)
      recipients.where(event_date: start_date..(start_date + offset)).count
    end
  end
end
