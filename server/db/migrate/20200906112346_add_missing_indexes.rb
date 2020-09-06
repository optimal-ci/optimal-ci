class AddMissingIndexes < ActiveRecord::Migration[6.0]
  def change
    add_index :builds, [:project_id, :build_number], unique: true
    add_index :nodes, [:build_id, :index], unique: true
  end
end
