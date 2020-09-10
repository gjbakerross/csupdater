class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|

      t.timestamps
      t.string :title
      t.string :sku
      t.string :url
    end
  end
end
