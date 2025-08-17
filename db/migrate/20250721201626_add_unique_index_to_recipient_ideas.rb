class AddUniqueIndexToRecipientIdeas < ActiveRecord::Migration[8.0]
  def change
    add_index :recipient_ideas, [ :recipient_id, :idea_id ], unique: true
  end
end
