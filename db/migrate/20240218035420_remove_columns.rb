class RemoveColumns < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :uin
    remove_column :users, :provider
  end
end
