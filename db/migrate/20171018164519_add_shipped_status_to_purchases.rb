class AddShippedStatusToPurchases < ActiveRecord::Migration[5.1]
  def change
    add_column :purchases, :shipped, :boolean, default: false
  end
end
