class CreateMeetings < ActiveRecord::Migration[7.1]
  def change
    create_table :meetings do |t|
      t.references :user, null: false, foreign_key: true
      t.datetime :date
      t.string :location
      t.boolean :recurring

      t.timestamps
    end
  end
end
