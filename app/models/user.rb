# frozen_string_literal: true

require 'net/http'

# Class that represents a user of the app
class User < ApplicationRecord
  validates :uin, :name, :email, :credits, presence: true
  validates :credits, numericality: { only_integer: true }

  def update_credits()
    uri = URI("https://tamu-dining-62fbd726fd19.herokuapp.com/users/#{self.uin}")
    res = Net::HTTP.get_response(uri)
    update({credits: res.body['credits']})
    puts self.credits
  end

  def subtract_credits(amount)
    # puts "before update: #{self.credits}"
    uri = URI("https://tamu-dining-62fbd726fd19.herokuapp.com/users/#{self.uin}/?credits=#{-1 * amount}")
    res = Net::HTTP.post_form(uri, 'q' => 'ruby', 'max' => '50')
    update_credits()
    puts "after update: #{self.credits}"

    return res.code
    # update({ credits: credits - amount })
  end

  def add_credits(amount)
    # puts "before update: #{self.credits}"
    uri = URI("https://tamu-dining-62fbd726fd19.herokuapp.com/users/#{self.uin}/?credits=#{amount}")
    res = Net::HTTP.post_form(uri, 'q' => 'ruby', 'max' => '50')
    update_credits()
    puts "after update: #{self.credits}"

    return res.code
    # update({ credits: credits + amount })
  end
end
