class CreateJoinTableItemPurchase < ActiveRecord::Migration[5.1]
  def change
    create_join_table :items, :purchases do |t|
      t.index [:item_id, :purchase_id]
    end
  end
end
