class RenameTypeAttribute < ActiveRecord::Migration[7.1]
  def change
    rename_column :users, :type, :user_type
    rename_column :transactions, :type, :transaction_type
  end
end
