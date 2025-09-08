class AddShipToCountryToRecipients < ActiveRecord::Migration[8.0]
  def change
    add_column :recipients, :ship_to_country, :string, default: "US", null: false
  end
end
