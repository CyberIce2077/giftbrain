module Recipients
  class RolloverAnnualEventDatesService < BaseService
    def call
      Recipient.with_repeat_annually
               .where(event_date: ..Time.zone.now.yesterday)
               .find_each do |recipient|
        recipient.update(event_date: recipient.event_date.next_year)
      end

      success!
    rescue StandardError => e
      errors.add(:base, e.message)
      log_error(e)
    end
  end
end
