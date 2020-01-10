class ChangeColumnNullTasks2 < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks, :end_on, :date, default: "", null: false
  end
end
