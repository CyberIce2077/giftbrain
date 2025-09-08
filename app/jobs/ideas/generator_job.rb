module Ideas
  class GeneratorJob < ApplicationJob
    queue_as :generator

    def perform(recipient)
      service = ::Ideas::GeneratorService.new(recipient)
      service.call

      validate_successful_service!(service)
    end
  end
end
