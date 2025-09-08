module RecipientIdeas
  class GenerateAffiliateLinksJob < ApplicationJob
    sidekiq_options retry: 5

    def perform(recipient_idea)
      service = ::RecipientIdeas::GenerateAffiliateLinksService.new(recipient_idea)
      service.call

      validate_successful_service!(service)
    end
  end
end
