class AddProjectIdToTask < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :project_id, :bigint
    add_index :tasks, :project_id
  end
end
