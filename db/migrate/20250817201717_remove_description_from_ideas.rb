class RemoveDescriptionFromIdeas < ActiveRecord::Migration[8.0]
  def change
    remove_column :ideas, :description
  end
end
