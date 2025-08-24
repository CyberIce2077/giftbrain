class CreateTeams < ActiveRecord::Migration[8.0]
  def change
    create_table :teams do |t|
      t.references :recipient, null: false, foreign_key: true, index: { unique: true }
      t.string :name
      t.integer :team_members_count, default: 0, null: false
      t.string :invitation_token, null: false
      t.boolean :invitation_token_enabled, default: false, null: false

      t.timestamps
    end

    add_index :teams, :invitation_token, unique: true
  end
end
