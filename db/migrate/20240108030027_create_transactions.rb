# frozen_string_literal: true

# Migration that creates the Transactions table in the DB
class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions do |t|
      t.string :uin
      t.string :type
      t.datetime :time
      t.integer :amount

      t.timestamps
    end
    add_index :transactions, :id, unique: true
  end
end
