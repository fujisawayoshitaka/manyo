class ChangeColumnNullTasks4 < ActiveRecord::Migration[5.2]
  def change
    change_column_default :tasks, :end_on, from: 'YYYY-MM-DD', to: Time.now
  end
end
