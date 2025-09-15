class CreateFavoriteProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :favorite_products do |t|
      t.references :recipient, null: false, foreign_key: true
      t.string :product_id, default: "", null: false
      t.integer :provider, default: 0, null: false
      t.string :name, default: "", null: false
      t.string :promotion_link, default: "", null: false
      t.string :image, default: "", null: false
      t.string :original_price, default: "", null: false
      t.string :sale_price, default: "", null: false
      t.string :discount, default: "", null: false

      t.timestamps
    end

    add_index :favorite_products, %i[recipient_id provider product_id], unique: true
  end
end
