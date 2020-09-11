class AddCoreProductsToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :core_products, :string
  end
end
