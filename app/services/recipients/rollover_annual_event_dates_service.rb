module Recipients
  class RolloverAnnualEventDatesService < BaseService
    def call
      recipient_scope.find_each do |recipient|
        recipient.update!(event_date: recipient.event_date.next_year)
        recipient.reminders.find_each(&:restore!)
      end

      success!
    rescue StandardError => e
      errors.add(:base, e.message)
      log_error(e)
    end

    private

    def recipient_scope
      Recipient.repeat_annually.where(event_date: ..Time.zone.now.yesterday)
    end
  end
end
