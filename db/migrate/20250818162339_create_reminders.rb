class CreateReminders < ActiveRecord::Migration[8.0]
  def change
    create_table :reminders do |t|
      t.boolean :active, default: true, null: false
      t.references :recipient, null: false, foreign_key: true
      t.integer :kind, default: 0, null: false
      t.datetime :discarded_at
      t.timestamps
    end

    add_index :reminders, [:recipient_id, :kind], unique: true
    add_index :reminders, :discarded_at
  end
end
