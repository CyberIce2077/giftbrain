class GiftIdeas::GeneratorJob < ApplicationJob
  queue_as :default

  def perform(recipient)
    ::GiftIdeas::GeneratorService.new(recipient).call
  end
end
