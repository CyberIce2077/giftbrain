module RecipientIdeas
  class GenerateAffiliateLinksService < BaseService
    attr_reader :recipient_idea

    def initialize(recipient_idea)
      super
      @recipient_idea = recipient_idea
    end

    def call
      service = Affiliate::Aliexpress::GenerateAffiliateLinkService.new(recipient_idea.name)
      service.call

      if service.success?
        recipient_idea.update!(affiliate_links: { aliexpress: service.data })
        update_idea_view
      end

      success!
    rescue StandardError => e
      errors.add(:base, e.message)
      log_error(e)
    end

    private

    def update_idea_view
      recipient_idea.broadcast_prepend_to(
        recipient_idea.recipient,
        target: recipient_idea,
        partial: "/recipients/idea_affiliate_links",
        locals: { recipient_idea: }
      )
    end
  end
end
