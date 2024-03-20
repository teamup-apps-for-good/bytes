class AddAcceptedToMeetings < ActiveRecord::Migration[7.1]
  def change
    add_column :meetings, :accepted, :boolean, default: false
  end
end
