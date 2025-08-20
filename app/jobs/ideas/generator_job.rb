module Ideas
  class GeneratorJob < ApplicationJob
    queue_as :generator

    def perform(recipient)
      service = ::Ideas::GeneratorService.new(recipient)
      service.call

      raise UnsuccessfulServiceError unless service.success?
    end
  end
end
