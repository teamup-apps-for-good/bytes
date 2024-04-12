# frozen_string_literal: true

require 'net/http'

# Class that represents a user of the app
class User < ApplicationRecord
  validates :uid, :name, :email, :user_type, presence: true
  attribute :admin, :boolean, default: false

  def fetch_num_credits
    uri = URI("https://tamu-dining-62fbd726fd19.herokuapp.com/users/#{uid}")
    res = Net::HTTP.get(uri)
    json_res = JSON.parse(res)
    json_res['credits']
  end

  def update_credits(amount)
    uri = URI("https://tamu-dining-62fbd726fd19.herokuapp.com/users/#{uid}/update_credits/#{amount}")

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = (uri.scheme == 'https')

    request = Net::HTTP::Patch.new(uri.request_uri)
    response = http.request(request)

    # if (response.code.to_i != 200)
    #   puts "The response is #{response}"
    #   puts "response code is #{response.code}"
    # end

    fetch_num_credits

    response
  end

  def set_admin
    uri = URI("https://tamu-dining-62fbd726fd19.herokuapp.com/administrators/#{email}/validate_admin")
    res = Net::HTTP.get(uri)
    json_res = JSON.parse(res)
    if json_res == true
      update(admin: true)
    else
      update(admin: false)
    end
  end
end
