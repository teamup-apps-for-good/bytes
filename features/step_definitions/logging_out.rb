Given('I am already logged in as an user with the email of {string}') do |email|
  visit root_path
  OmniAuth.config.test_mode = true
  OmniAuth.config.add_mock(
    :google_oauth2,
    info: { email: email }
  )
  click_on 'Login with Google'
  
end

Given('there is an user with the email of {string}, uin of {string}, and {int} credits in the external API') do |email, uin, credit|
  response = {
    :credits => credit
  }
  stub_request(:get, %{https://tamu-dining-62fbd726fd19.herokuapp.com/users/#{uin}}).
  to_return(status: 200, body: response.to_json)
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