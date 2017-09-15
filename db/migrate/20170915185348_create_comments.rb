class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.string :user_email
      t.text :body
      t.integer :item_id

      t.timestamps
    end
  end
end
