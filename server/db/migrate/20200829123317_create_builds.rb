class CreateBuilds < ActiveRecord::Migration[6.0]
  def change
    create_table :builds do |t|
      t.integer :total_files_count
      t.string :ci
      t.string :build_number
      t.string :queue, array: true, default: []
      t.string :processed, array: true, default: []

      t.timestamps
    end
    add_index :builds, :build_number
  end
end
