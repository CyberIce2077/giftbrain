module RecipientIdeas
  class GenerateAffiliateLinksJob < ApplicationJob
    def perform(recipient_idea)
      service = ::RecipientIdeas::GenerateAffiliateLinksService.new(recipient_idea)
      service.call

      raise UnsuccessfulServiceError unless service.success?
    end
  end
end
