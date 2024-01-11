# frozen_string_literal: true

# Renames type attributes for users and transactions in order to be more specific
class RenameTypeAttribute < ActiveRecord::Migration[7.1]
  def change
    rename_column :users, :type, :user_type
    rename_column :transactions, :type, :transaction_type
  end
end
