class ChangeAdminDefaultOnUsers < ActiveRecord::Migration[5.2]
  def change
    change_column_default :users, :admin, from: false, to: true
  end
end
