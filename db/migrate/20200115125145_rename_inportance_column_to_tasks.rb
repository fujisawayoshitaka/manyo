class RenameInportanceColumnToTasks < ActiveRecord::Migration[5.2]
  def change
    rename_column :tasks, :inportance, :importance
  end
end
