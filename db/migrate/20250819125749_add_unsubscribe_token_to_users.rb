class AddUnsubscribeTokenToUsers < ActiveRecord::Migration[8.0]
  def up
    add_column :users, :subscribed, :boolean, default: true, null: false
    add_column :users, :unsubscribe_token, :string

    User.reset_column_information
    User.find_each do |u|
      u.update_column(:unsubscribe_token, SecureRandom.hex(32))
    end

    change_column_null :users, :unsubscribe_token, false
    add_index :users, :unsubscribe_token, unique: true
  end

  def down
    remove_index :users, :unsubscribe_token
    remove_column :users, :unsubscribe_token
    remove_column :users, :subscribed
  end
end
