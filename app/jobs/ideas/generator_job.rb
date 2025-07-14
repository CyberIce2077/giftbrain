class Ideas::GeneratorJob < ApplicationJob
  queue_as :default

  def perform(recipient)
    ::Ideas::GeneratorService.new(recipient).call
  end
end
