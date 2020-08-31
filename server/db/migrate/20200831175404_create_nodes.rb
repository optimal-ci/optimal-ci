class CreateNodes < ActiveRecord::Migration[6.0]
  def change
    create_table :nodes do |t|
      t.references :build, null: false, foreign_key: true
      t.integer :duration

      t.timestamps
    end
  end
end
