class CreateJoinTableItemPurchase < ActiveRecord::Migration[5.1]
  def change
    create_join_table :items, :purchases do |t|
      t.index [:item_id, :purchase_id]
      # t.index [:purchase_id, :item_id]
    end
  end
end
