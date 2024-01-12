# frozen_string_literal: true

# Migration that creates credit pool which stores donated credits available
class CreateCreditPools < ActiveRecord::Migration[7.1]
  def change
    create_table :credit_pools do |t|
      t.integer :credits

      t.timestamps
    end
  end
end
