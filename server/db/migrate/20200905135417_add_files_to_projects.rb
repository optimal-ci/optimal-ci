class AddFilesToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :files, :jsonb, default: {}, null: false
  end
end
