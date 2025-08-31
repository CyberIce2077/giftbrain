class AddPublicTokenAndPublicJoinToTeams < ActiveRecord::Migration[8.0]
  def change
    change_table :teams do |t|
      t.boolean :public_join, default: false, null: false
      t.string :public_token, null: false
    end

    add_index :teams, :public_token, unique: true
  end
end
