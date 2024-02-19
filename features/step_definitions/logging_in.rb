# frozen_string_literal: true

Given('I am a user with the email of {string}') do |email|
  OmniAuth.config.test_mode = true
  OmniAuth.config.add_mock(
    :google_oauth2,
    info: { email: }
  )
end

And('I click on the {string} button') do |string|
  click_on string
end

Then('I should be logged in successfully') do
  expect(page).to have_current_path(user_profile_path)
end

Then('I should failed to log in with {string}') do |string|
  expect(page).to have_current_path(root_path)
  expect(page).to have_content(string)
end

Then('I should not be logged in') do
  expect(page).to have_current_path("/users/new")
end
