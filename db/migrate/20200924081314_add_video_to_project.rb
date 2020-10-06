class AddVideoToProject < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :youtube, :string
  end
end
