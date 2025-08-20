module Recipients
  class RolloverAnnualEventDatesJob < ApplicationJob
    def perform
      super { ::Recipients::RolloverAnnualEventDatesService }
    end
  end
end
