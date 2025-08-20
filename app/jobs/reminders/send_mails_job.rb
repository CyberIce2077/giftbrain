module Reminders
  class SendMailsJob < ApplicationJob
    def perform
      super { ::Reminders::SendMailsService }
    end
  end
end
