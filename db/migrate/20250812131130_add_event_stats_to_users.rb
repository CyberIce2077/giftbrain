class AddEventStatsToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :event_stats, :jsonb, default: {}, null: false
  end
end
