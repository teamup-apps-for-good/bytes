# frozen_string_literal: true

# class that represents postings for in-person meetings
class Meeting < ApplicationRecord
  before_validation :set_defaults
  validates_presence_of :uid, :date, :time, :location

  private

  def set_defaults
    self.accepted ||= false
    self.accepted_uid ||= nil
  end
end
