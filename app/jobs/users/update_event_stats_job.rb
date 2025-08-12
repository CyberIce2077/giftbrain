module Users
  class UpdateEventStatsJob < ApplicationJob
    def perform(user)
      ::Users::UpdateEventStatsService.new(user).call
    end
  end
end
