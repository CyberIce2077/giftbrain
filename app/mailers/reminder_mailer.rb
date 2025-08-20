class ReminderMailer < ApplicationMailer
  helper ApplicationHelper

  def notify(reminder)
    extend ApplicationHelper

    @reminder = reminder
    @recipient = reminder.recipient
    @user = @recipient.creator
    mail(
      to: @user.email,
      subject: "GiftBrain Reminder: #{event_due_date(@reminder)}"
    )
  end
end
