class CreateRecipientIdeas < ActiveRecord::Migration[8.0]
  def change
    create_table :recipient_ideas do |t|
      t.references :recipient, null: false, foreign_key: true
      t.references :idea, null: false, foreign_key: true
      t.integer :priority, default: 0, null: false

      t.timestamps
    end
  end
end
