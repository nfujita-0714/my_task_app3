class RenameContentsColumnToTasks < ActiveRecord::Migration[5.2]
  def change
    rename_column :tasks, :contents, :content
  end
end
