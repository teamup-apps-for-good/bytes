class DropSchools < ActiveRecord::Migration[7.1]
  def change
    drop_table :schools
  end
end
