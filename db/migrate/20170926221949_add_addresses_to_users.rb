class AddAddressesToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :address_line1, :string
    add_column :users, :address_line2, :string
    add_column :users, :city, :string
  end
end
