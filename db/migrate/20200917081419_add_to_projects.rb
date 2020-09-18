class AddToProjects < ActiveRecord::Migration[6.0]
  def change
    remove_column :projects, :language_id
  end
end
