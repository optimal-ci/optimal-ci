class AddAddHttpCallsToNodes < ActiveRecord::Migration[6.0]
  def change
    add_column :nodes, :http_calls_count, :integer
    add_column :nodes, :http_calls_time, :float
  end
end
