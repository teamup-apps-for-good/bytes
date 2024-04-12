# frozen_string_literal: true

Given('I am already logged in as an user with the email of {string}') do |email|
  visit root_path
  OmniAuth.config.test_mode = true
  OmniAuth.config.add_mock(
    :google_oauth2,
    info: { email: }
  )
  stub_request(:get, "https://tamu-dining-62fbd726fd19.herokuapp.com/administrators/#{email}/validate_admin")
    .with(
      headers: {
        'Accept' => '*/*',
        'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'Host' => 'tamu-dining-62fbd726fd19.herokuapp.com',
        'User-Agent' => 'Ruby'
      }
    )
    .to_return(status: 200, body: 'false', headers: {})
  click_on 'Login with Google'
  visit user_profile_path
end

And('I am on the profile page') do
  visit user_profile_path
end

When('the user presses {string}') do |string|
  click_on string
end

Then('I should be logged out successfully') do
  expect(page).to have_current_path(root_path)
end
