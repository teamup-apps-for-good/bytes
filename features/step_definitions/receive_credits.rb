# frozen_string_literal: true

Given('that I am logged in an account with {int} credits') do |int|
  visit root_path
  @user = User.create(name: 'Sam', uin: '11112222', email: 's@tamu.edu', credits: int, user_type: 'recipient',
                      date_joined: '01/01/2022')
  @user_id = @user.id
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

And('I fill in {string} with {int}') do |name, value|
  fill_in name, with: value
end

Then('I should be on the profile page') do
  visit "/users/profile"
end

Then('I should have {int} credits') do |num_credits|
  expect(page).to have_content("Credits: #{num_credits}")
end

# steps for second receive_credit scenario

And('the number of available credits is {int}') do |num_credits|
  expect(page).to have_content("Number of credits available in pool: #{num_credits}")
end

Then('I should be on the receive page') do
  expect(current_path).to eq("/users/profile/receive")
end

And('I currently have {int} credits') do |int|
  expect(page).to have_content("You currently have #{int} credits")
end
