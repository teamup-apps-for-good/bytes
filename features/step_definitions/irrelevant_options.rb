# frozen_string_literal: true

Given('I am a {string} profile') do |string|
  user = User.create(name: 'John', uid: '11110000', email: 'john@tamu.edu', credits: '9', user_type: string.to_s,
                     date_joined: '01/01/2022')

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
