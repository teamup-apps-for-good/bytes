Given('I am on the login page') do
  visit root_path
end

When('I click on the {string} button') do |string|
    OmniAuth.config.test_mode = true
    OmniAuth.config.add_mock(
        :google_oauth2,
        uid: '123456',
        info: { email: 'example@tamu.edu' }
    )
    click_on string
end

When('I log in with a tamu.edu email') do
  pending # Write code here that turns the phrase above into concrete actions
end

Then('I should be logged in successfully') do
  pending # Write code here that turns the phrase above into concrete actions
end
