class RemoveGenerationDurationFromRecipients < ActiveRecord::Migration[8.0]
  def change
    remove_column :recipients, :generation_duration, :integer, default: 0, null: false
  end
end
