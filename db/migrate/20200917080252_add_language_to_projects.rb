class AddLanguageToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :language_id, :string
  end
end
