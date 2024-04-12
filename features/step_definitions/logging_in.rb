# frozen_string_literal: true

Given('I am a user with the email of {string}') do |email|
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

  OmniAuth.config.test_mode = true
  OmniAuth.config.add_mock(
    :google_oauth2,
    info: { email: }
  )
end

When('I click on the {string} button') do |string|
  click_on string
end

Then('I should be logged in successfully') do
  expect(page.current_path).to match(%r{^(/users/profile|/users/new)$})
end

Then('I should failed to log in with {string}') do |string|
  expect(page).to have_current_path(root_path)
  expect(page).to have_content(string)
end

Then('I should not be logged in') do
  expect(page).to have_current_path('/users/new')
end
