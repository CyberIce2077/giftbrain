class CreateGiftIdeas < ActiveRecord::Migration[8.0]
  def change
    create_table :gift_ideas do |t|
      t.string :name
      t.string :description

      t.timestamps
    end

    add_index :gift_ideas, :name, unique: true
  end
end
