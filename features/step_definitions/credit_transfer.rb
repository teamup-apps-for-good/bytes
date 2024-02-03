# frozen_string_literal: true

Given('the following users exist:') do |table|
  User.destroy_all
  table.hashes.each do |user|
    User.create user
  end
end

Given('the following credit pools exist:') do |table|
  CreditPool.destroy_all
  table.hashes.each do |pool|
    CreditPool.create pool
  end
end

Given('API allows for {int} credit update for user with uin of {string}') do |credit, uin|
  response = {
    :message => 'Credits updated successfully'
  }
  stub_request(:patch, %{https://tamu-dining-62fbd726fd19.herokuapp.com/users/#{uin}/update_credits/#{credit}}).
  to_return(status: 200, body: response.to_json)
end

Given('API does not allows for {int} credit update for user with uin of {string}') do |credit, uin|
  stub_request(:patch, %{https://tamu-dining-62fbd726fd19.herokuapp.com/users/#{uin}/update_credits/#{credit}}).
  to_return(status: 400, body: '')
end

When('I go to the {string} page') do |string|
  visit "/users/profile/#{string}"
end

When('I fill out {string} with {string}') do |string, string2|
  fill_in string, with: string2
end

When('I press the {string} button') do |string|

  click_button string

  
end

When('I press the {string} button as this user') do |string|

  @pool = CreditPool.find_by(credits: 50)
  @pool_before = @pool.credits
  puts @pool_before

  stub_request(:patch, "https://tamu-dining-62fbd726fd19.herokuapp.com/users/#{@user.uin}/update_credits/10").
    with(
      headers: {
      'Accept'=>'*/*',
      'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'User-Agent'=>'Ruby'
    }).
  to_return(status: 200, body: "", headers: {})

  click_button string

  
end

