module Recipients
  class RolloverAnnualEventDatesJob < ApplicationJob
    def perform
      ::Recipients::RolloverAnnualEventDatesService.new.call
    end
  end
end
