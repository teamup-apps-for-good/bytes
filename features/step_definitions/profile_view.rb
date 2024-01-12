# frozen_string_literal: true

Then('I should see my {string}') do |string|
  expect(page).to have_content(string)
  expect(page).to have_content(@name) if string == 'Name'
  expect(page).to have_content(@email) if string == 'Email'
  expect(page).to have_content(@credits) if string == 'Credits'
  expect(page).to have_content(@user_type) if string == 'Type'
  expect(page).to have_content(@uin) if string == 'UIN'
end

Then('I should see {string}') do |string|
  expect(page).to have_content(string)
end

Given('I am on the login page') do
  visit root_path
end

Given('I am logged in') do
  user = User.create(name: 'John', uin: '11110000', email: 'john@tamu.edu', credits: '50', user_type: 'donor',
                     date_joined: '01/01/2022')
  @user = user
  @id = user.id
  @name = user.name
  @email = user.email
  @credits = user.credits
  @user_type = user.user_type
  @uin = user.uin
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
  expect(current_path).to eq(user_transfer_path)
end
