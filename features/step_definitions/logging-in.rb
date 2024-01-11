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

Then('I should be logged in successfully') do
    expect(page).to have_current_path('/users/new', ignore_query: true)
end
