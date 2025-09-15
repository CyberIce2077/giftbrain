class AddImageToIdeas < ActiveRecord::Migration[8.0]
  def change
    add_column :ideas, :image, :string, default: "", null: false
  end
end
