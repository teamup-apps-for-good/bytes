class CreateCreditPools < ActiveRecord::Migration[7.1]
  def change
    create_table :credit_pools do |t|
      t.integer :credits

      t.timestamps
    end
  end
end
