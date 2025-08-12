class AddRepeatAnnuallyToRecipients < ActiveRecord::Migration[8.0]
  def change
    add_column :recipients, :repeat_annually, :boolean, default: true, null: false
  end
end
