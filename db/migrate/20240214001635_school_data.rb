class SchoolData < ActiveRecord::Migration[7.1]
  def change
    create_table :schools do |t|
      t.string :name
      t.string :domain
      t.string :logo
    end
  end
end
