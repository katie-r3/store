class CreatePurchases < ActiveRecord::Migration[5.1]
  def change
    create_table :purchases do |t|
      t.integer :item_id
      t.integer :buyer_id

      t.timestamps
    end
    add_index :purchases, [:item_id, :buyer_id], unique: true
  end
end
