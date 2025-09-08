module Ideas
  class BulkCreateJob < ApplicationJob
    def perform(recipient, data)
      service = ::Ideas::BulkCreateService.new(recipient, data)
      service.call

      validate_successful_service!(service)
    end
  end
end
