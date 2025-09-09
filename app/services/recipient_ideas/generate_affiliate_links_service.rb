module RecipientIdeas
  class GenerateAffiliateLinksService < BaseService
    attr_reader :recipient_idea, :recipient, :idea

    def initialize(recipient_idea)
      super
      @recipient_idea = recipient_idea
      @recipient = recipient_idea.recipient
      @idea = recipient_idea.idea
    end

    def call
      service = aliexpress_affiliate_service.new(idea.name, recipient.ship_to_country)
      service.call

      @data = service.data
      validate_data_presence!

      idea.update!(image: @data["product_main_image_url"])
      recipient_idea.update!(affiliate_links: { aliexpress: @data["promotion_link"] })
      update_idea_view

      success!
    rescue StandardError => e
      errors.add(:base, e.message)
      log_error(e)
    end

    private

    def update_idea_view
      idea.broadcast_update_to(
        recipient,
        target: idea,
        partial: "/recipients/idea",
        locals: { idea:, recipient:, recipient_ideas: [recipient_idea] }
      )
    end

    def aliexpress_affiliate_service
      Affiliate::Aliexpress::GenerateAffiliateLinkService
    end
  end
end
