class AddEventDateToRecipient < ActiveRecord::Migration[8.0]
  def change
    add_column :recipients, :event_date, :date
    add_index :recipients, :event_date
  end
end
