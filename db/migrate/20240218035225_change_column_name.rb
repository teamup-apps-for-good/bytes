class ChangeColumnName < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :uid
    rename_column :users, :uin, :uid
    rename_column :transactions, :uin, :uid
  end
end
