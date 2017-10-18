class AddOrderedStatusToPurchases < ActiveRecord::Migration[5.1]
  def change
    add_column :purchases, :ordered, :boolean, default: false
  end
end
