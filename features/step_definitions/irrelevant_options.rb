# frozen_string_literal: true

Given('I am a {string} profile') do |string|
  user = User.create(name: 'John', uid: '11110000', email: 'john@tamu.edu', credits: '9', user_type: string.to_s,
                     date_joined: '01/01/2022')

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
  OmniAuth.config.test_mode = true
  OmniAuth.config.add_mock(
    :google_oauth2,
    uid: user.id,
    info: { email: user.email }
  )
  click_on 'Login with Google'
end

Then('I should not see {string}') do |string|
  expect(page).to have_no_content(string)
end
