class CreateSlugs < ActiveRecord::Migration[5.1]
  def change
    create_table :slugs do |t|

      t.timestamps
    end
  end
end
