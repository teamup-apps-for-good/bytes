# frozen_string_literal: true

Then('I should see my {string}') do |string|
  expect(page).to have_content(string)
  expect(page).to have_content(@name) if string == 'Name'
  expect(page).to have_content(@email) if string == 'Email'
  expect(page).to have_content(@credits) if string == 'Credits'
  expect(page).to have_content(@user_type) if string == 'Type'
  expect(page).to have_content(@uid) if string == 'UIN'
end

Then('I should see {string}') do |string|
  expect(page).to have_content(string)
end

Given('I am on the login page') do
  visit root_path
end

Given('I am logged in') do
  user = User.create(name: 'John', uid: '3242985', email: 'john@tamu.edu', credits: '50', user_type: 'donor',
                     date_joined: '01/01/2022')

  # This stub is for handling the external api call that is made when logging in
  response = {
    credits: user.credits,
    first_name: user.name,
    email: user.email,
    uid: user.uid
  }
  stub_request(:get, %(https://tamu-dining-62fbd726fd19.herokuapp.com/users/#{user.uid}))
    .to_return(status: 200, body: response.to_json)

  stub_request(:get, "https://tamu-dining-62fbd726fd19.herokuapp.com/administrators/#{user.email}/validate_admin")
    .with(
      headers: {
        'Accept' => '*/*',
        'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'Host' => 'tamu-dining-62fbd726fd19.herokuapp.com',
        'User-Agent' => 'Ruby'
      }
    )
    .to_return(status: 200, body: { valid: false }.to_json, headers: {})

  @user = user
  @id = user.id
  @name = user.name
  @email = user.email
  @credits = user.credits
  @user_type = user.user_type
  @uid = user.uid
  @user_school = CreditPool.find_by(email_suffix: @user.email.partition('@').last)
  OmniAuth.config.test_mode = true
  OmniAuth.config.add_mock(
    :google_oauth2,
    uid: user.id,
    info: { email: user.email }
  )
  click_on 'Login with Google'
end

Given('I log in with a different uid') do
  user = User.create(name: 'John', uid: '3242986', email: 'john@tamu.edu', credits: '50', user_type: 'donor',
                     date_joined: '01/01/2022')

  # This stub is for handling the external api call that is made when logging in
  response = {
    credits: user.credits,
    first_name: user.name,
    email: user.email,
    uid: user.uid
  }
  stub_request(:get, %(https://tamu-dining-62fbd726fd19.herokuapp.com/users/#{user.uid}))
    .to_return(status: 200, body: response.to_json)

  stub_request(:get, "https://tamu-dining-62fbd726fd19.herokuapp.com/administrators/#{user.email}/validate_admin")
    .with(
      headers: {
        'Accept' => '*/*',
        'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'Host' => 'tamu-dining-62fbd726fd19.herokuapp.com',
        'User-Agent' => 'Ruby'
      }
    )
    .to_return(status: 200, body: 'false', headers: {})

  @user = user
  @id = user.id
  @name = user.name
  @email = user.email
  @credits = user.credits
  @user_type = user.user_type
  @uid = user.uid
  @user_school = CreditPool.find_by(email_suffix: @user.email.partition('@').last)
  OmniAuth.config.test_mode = true
  OmniAuth.config.add_mock(
    :google_oauth2,
    uid: user.id,
    info: { email: user.email }
  )
  click_on 'Login with Google'
end

When('I go to the profile page') do
  visit('/users/profile')
end

When('I click the {string} link') do |string|
  click_on(string)
end

Then('I should be on the Transfer page') do
  expect(page).to have_current_path(user_transfer_path, ignore_query: true)
end

Then('I should have a submit button with the text {string}') do |string|
  expect(find('input[type="submit"]').value).to eq(string)
end

And('I should not have a submit button with the text {string}') do |string|
  expect(find('input[type="submit"]').value).not_to eq(string)
end

Then('I should see the school logo displayed') do
  expect(page).to have_css('.school-logo')
end
