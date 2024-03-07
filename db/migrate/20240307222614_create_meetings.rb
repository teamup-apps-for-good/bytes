class CreateMeetings < ActiveRecord::Migration[7.1]
  def change
    create_table :meetings do |t|
      t.string :uid
      t.date :date
      t.time :time
      t.string :location
      t.boolean :recurring

      t.timestamps
    end
  end
end
