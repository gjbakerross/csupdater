class AddReference < ActiveRecord::Migration[6.0]
  def change
    add_reference :projects, :language, index: true
  end
end
