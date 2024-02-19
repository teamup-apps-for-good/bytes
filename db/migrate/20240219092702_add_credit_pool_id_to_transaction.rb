class AddCreditPoolIdToTransaction < ActiveRecord::Migration[7.1]
  def change
    add_column :transactions, :credit_pool_id, :string
  end
end
