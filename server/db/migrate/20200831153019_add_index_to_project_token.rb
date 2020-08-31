class AddIndexToProjectToken < ActiveRecord::Migration[6.0]
  def change
    add_index :projects, :token
  end
end
