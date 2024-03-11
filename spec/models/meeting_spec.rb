require 'rails_helper'

RSpec.describe Meeting, type: :model do
  it "is valid" do
    expect(Meeting.new(uid: 1, date: '2024-03-11', time: '12:00 PM', location: "here")).to be_valid
  end
  it "is not valid without a uid" do
    expect(Meeting.new(uid: nil, date: '2024-03-11', time: '12:00 PM', location: "here")).to_not be_valid
  end
  it "is not valid without a date" do
    expect(Meeting.new(uid: 1, date: nil, time: '12:00 PM', location: "here")).to_not be_valid
  end
  it "is not valid without a time" do
    expect(Meeting.new(uid: 1, date: '2024-03-11', time: nil, location: "here")).to_not be_valid
  end
  it "is not valid without a location" do
    expect(Meeting.new(uid: 1, date: '2024-03-11', time: '12:00 PM', location: nil)).to_not be_valid
  end
end
