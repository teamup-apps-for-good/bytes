Given('I am a user with the email of {string}') do |email|
  OmniAuth.config.test_mode = true
  OmniAuth.config.add_mock(
      :google_oauth2,
      info: { email: email }
  )
end

And('I click on the {string} button') do |string|
  click_on string
end

Then('I should be logged in successfully') do
  expect(page).to have_current_path('/users/profile', ignore_query: true)
end