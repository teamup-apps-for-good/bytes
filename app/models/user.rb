# frozen_string_literal: true

require 'net/http'

# Class that represents a user of the app
class User < ApplicationRecord
  validates :uin, :name, :email, presence: true
  validates :credits, numericality: { only_integer: true }

  def get_num_credits()
    uri = URI("https://tamu-dining-62fbd726fd19.herokuapp.com/users/#{self.uin}")
    res = Net::HTTP.get(uri)
    json_res = JSON.parse(res)
    update({credits: json_res['credits']})
    puts "number of credits: #{self.credits}"
  end

  def update_credits(amount)
    uri = URI("https://tamu-dining-62fbd726fd19.herokuapp.com/users/#{self.uin}/update_credits/#{amount}")

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = (uri.scheme == 'https')

    request = Net::HTTP::Patch.new(uri.request_uri)
    response = http.request(request)

    if (response.code.to_i != 200)
      puts "The response is #{response}"
      puts "response code is #{response.code}"
    end

    return response
  end

  def subtract_credits(amount)
    # puts "before update: #{self.credits}"
    response = update_credits(-1 * amount)

    # update user credit count on bytes
    get_num_credits()
    puts "after update: #{self.credits}"

    return response
    # update({ credits: credits - amount })
  end

  def add_credits(amount)
    # puts "before update: #{self.credits}"
    response = update_credits(amount)

    # update user credit count on bytes
    get_num_credits()
    puts "after update: #{self.credits}"

    return response
    # update({ credits: credits + amount })
  end
end
