class AddInportanceToTask < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :inportance, :integer, default:0
  end
end
