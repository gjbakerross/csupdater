class CreateLanguages < ActiveRecord::Migration[6.0]
  def change
    create_table :languages do |t|

      t.timestamps
      t.string :name
      t.string :code
    end
  end
end
