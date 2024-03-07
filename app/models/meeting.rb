class Meeting < ApplicationRecord
  validates_presence_of :uid, :date, :time, :location
end