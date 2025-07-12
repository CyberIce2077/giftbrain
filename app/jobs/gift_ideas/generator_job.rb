class GiftIdeas::GeneratorJob < ApplicationJob
  queue_as :default

  def perform(gift_target)
    ::GiftIdeas::GeneratorService.new(gift_target).call
  end
end
