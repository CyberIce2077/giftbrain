module Reminders
  class SendMailsJob < ApplicationJob
    def perform
      ::Reminders::SendMailsService.new.call
    end
  end
end
