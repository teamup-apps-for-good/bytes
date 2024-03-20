class AddAcceptedUidToMeetings < ActiveRecord::Migration[7.1]
  def change
    add_column :meetings, :accepted_uid, :string
  end
end
