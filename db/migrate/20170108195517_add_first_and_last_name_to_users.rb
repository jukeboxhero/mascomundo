class AddFirstAndLastNameToUsers < ActiveRecord::Migration
  def change
    add_column :spree_users, :first_name, :string, null: false
    add_column :spree_users, :last_name, :string, null: false
  end
end
