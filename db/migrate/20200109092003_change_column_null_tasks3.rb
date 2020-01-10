class ChangeColumnNullTasks3 < ActiveRecord::Migration[5.2]
  def change
    change_column_default :tasks, :end_on, from: "", to: 'YYYY-MM-DD'
  end
end
