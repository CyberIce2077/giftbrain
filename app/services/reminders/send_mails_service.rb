module Reminders
  class SendMailsService < BaseService
    attr_reader :today

    def initialize
      @today = Time.zone.now
    end

    def call
      reminder_kinds.each do |kind, date|
        reminder_scope(kind, date).find_each do |reminder|
          ReminderMailer.notify(reminder).deliver_later(queue: :mailers)
          reminder.update!(sent_at: Time.zone.now)
        end
      end

      success!
    rescue StandardError => e
      errors.add(:base, e.message)
      log_error(e)
    end

    private

    def reminder_kinds
      {
        same_day: today,
        one_day: today + 1.day,
        one_week: today + 1.week,
        one_month: today + 1.month
      }
    end

    def reminder_scope(kind, date)
      Reminder.active
              .public_send(:"#{kind}_kind")
              .where(recipient: recipient_scope(date))
    end

    def recipient_scope(date)
      Recipient.with_subscribed_creator.where(event_date: date)
    end
  end
end
