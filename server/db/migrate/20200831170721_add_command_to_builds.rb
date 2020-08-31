class AddCommandToBuilds < ActiveRecord::Migration[6.0]
  def change
    add_column :builds, :command, :string
  end
end
