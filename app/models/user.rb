# frozen_string_literal: true

# Class that represents a user of the app
class User < ApplicationRecord
  validates :uin, :name, :email, presence: true
  def subtract_credits(amount)
    # do the actual subtraction update in the database
    # puts "before update: #{self.credits}"
    update({ credits: credits - amount })
    # puts "after update: #{self.credits}"
  end

  def add_credits(amount)
    # do the actual addition update in the database
    # puts "before update: #{self.credits}"
    update({ credits: credits + amount })
    # puts "after update: #{self.credits}"
  end
end
