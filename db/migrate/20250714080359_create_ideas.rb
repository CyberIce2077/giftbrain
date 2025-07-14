class CreateIdeas < ActiveRecord::Migration[8.0]
  def change
    create_table :ideas do |t|
      t.string :name
      t.text :description

      t.timestamps
    end

    add_index :ideas, :name, unique: true
  end
end
