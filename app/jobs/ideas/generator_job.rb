module Ideas
  class GeneratorJob < ApplicationJob
    queue_as :generator

    def perform(...)
      super { ::Ideas::GeneratorService.new(...) }
    end
  end
end
