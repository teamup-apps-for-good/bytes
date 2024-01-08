class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :uin
      t.string :name
      t.string :email
      t.integer :credits
      t.string :type
      t.date :date_joined

      t.timestamps
    end
    add_index :users, :uin, unique: true
  end
end
