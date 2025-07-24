module Ideas
  class GeneratorJob < ApplicationJob
    queue_as :generator

    def perform(recipient)
      ::Ideas::GeneratorService.new(recipient).call
    end
  end
end
