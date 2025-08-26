class RenameIdeasCountToRecipientIdeasCountInRecipients < ActiveRecord::Migration[8.0]
  def change
    rename_column :recipients, :ideas_count, :recipient_ideas_count
  end
end
