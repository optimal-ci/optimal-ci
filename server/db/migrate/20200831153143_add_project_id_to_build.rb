class AddProjectIdToBuild < ActiveRecord::Migration[6.0]
  def change
    add_reference :builds, :project
  end
end
