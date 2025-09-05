class AddAffiliateLinksToRecipientIdeas < ActiveRecord::Migration[8.0]
  def change
    add_column :recipient_ideas, :affiliate_links, :jsonb, default: {}, null: false
  end
end
