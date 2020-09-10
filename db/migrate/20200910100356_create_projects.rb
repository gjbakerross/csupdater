class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|

      t.timestamps
      t.string :uniqueid
      t.string :title
      t.string :intro
      t.string :mainimage
      t.string :image1
      t.string :image2
      t.string :image3
      t.string :level
      t.string :time
      t.string :how_to_make
      t.string :shopping_list
      t.string :what_youll_need
      t.string :tip
      t.string :template
      t.string :tags
      t.string :supervision
      t.string :products
      t.string :categories
    end
  end
end
