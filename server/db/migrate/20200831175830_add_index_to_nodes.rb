class AddIndexToNodes < ActiveRecord::Migration[6.0]
  def change
    add_column :nodes, :index, :integer
  end
end
