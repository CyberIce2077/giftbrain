class CreateGiftTargetGiftIdeas < ActiveRecord::Migration[8.0]
  def change
    create_table :gift_target_gift_ideas do |t|
      t.references :gift_target, null: false, foreign_key: true
      t.references :gift_idea, null: false, foreign_key: true
      t.integer :priority, default: 0, null: false

      t.timestamps
    end
  end
end
