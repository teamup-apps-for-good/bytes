# frozen_string_literal: true

Given('that I am logged in an account with {int} credits') do |int|
  visit root_path
  @user = User.create(name: 'Sam', uid: '11112222', email: 's@tamu.edu', credits: int, user_type: 'recipient',
                      date_joined: '01/01/2022')
  @user_id = @user.id

  # This stub is for handling the external api call that is made when logging in
  response = {
    credits: @user.credits,
    first_name: @user.name,
    email: @user.email,
    uid: @user.uid
  }
  stub_request(:get, %(https://tamu-dining-62fbd726fd19.herokuapp.com/users/#{@user.uid}))
    .to_return(status: 200, body: response.to_json)

  stub_request(:get, "https://tamu-dining-62fbd726fd19.herokuapp.com/administrators/#{@user.email}/validate_admin")
    .with(
      headers: {
        'Accept' => '*/*',
        'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'Host' => 'tamu-dining-62fbd726fd19.herokuapp.com',
        'User-Agent' => 'Ruby'
      }
    )
    .to_return(status: 200, body: 'false', headers: {})

  OmniAuth.config.test_mode = true
  OmniAuth.config.add_mock(
    :google_oauth2,
    uid: @user.id,
    info: { email: @user.email }
  )
  click_on 'Login with Google'
end

And('I am on the {string} page') do |string|
  visit "/users/profile/#{string}"
end

And('I fill in {string} with {string}') do |name, value|
  fill_in name, with: value
end

Then('I should be on the profile page') do
  visit '/users/profile'
end

Then('I should have {int} credits') do |_num_credits|
  # look at pool instead
  # expect(page).to have_content("Credits: #{num_credits}")
  @pool_after = @pool.credits
  expect(@pool_before - @pool_after).to eq @credits_recieved
end

Then('I should see CONFIRMATION Sucessfully recieved {int} credits!') do |num|
  expect(page).to have_content('CONFIRMATION')
  @credits_recieved = num
  @pool.credits -= num
end
# steps for second receive_credit scenario

And('the number of available credits is {int}') do |num_credits|
  expect(page).to have_content("Pool Credits: #{num_credits}")
end

Then('I should be on the receive page') do
  expect(page).to have_current_path('/users/profile/receive', ignore_query: true)
end

And('I currently have {int} credits') do |int|
  expect(page).to have_content("User Credits: #{int}")
end
