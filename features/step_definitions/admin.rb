Given('that I am an admin with the email {string}') do |email|
    #   first_name: 'First',
    #   last_name: 'Last',
    #   email:,
    #   uin: uid
    # }
    response = { success: true }
    stub_request(:get, %(https://tamu-dining-62fbd726fd19.herokuapp.com/administrators/#{email}/validate_admin))
      .to_return(status: 200, body: response.to_json)
end

Given('I am already logged in as an admin with the email of {string}') do |email|
    visit root_path
    OmniAuth.config.test_mode = true
    OmniAuth.config.add_mock(
      :google_oauth2,
      info: { email: }
    )
    stub_request(:get, "https://tamu-dining-62fbd726fd19.herokuapp.com/administrators/#{email}/validate_admin").
          with(
            headers: {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Host'=>'tamu-dining-62fbd726fd19.herokuapp.com',
            'User-Agent'=>'Ruby'
            }).
          to_return(status: 200, body: "true", headers: {})
    click_on 'Login with Google'
    visit user_profile_path
end

Given('I am logged in as an admin') do
  user = User.create(name: 'John', uid: '3242985', email: 'John@tamu.edu', credits: '50', user_type: 'donor',
                     date_joined: '01/01/2022')

  # This stub is for handling the external api call that is made when logging in
  response = {
    credits: user.credits,
    first_name: user.name,
    email: user.email,
    uid: user.uid
  }
  stub_request(:get, %(https://tamu-dining-62fbd726fd19.herokuapp.com/users/#{user.uid}))
    .to_return(status: 200, body: response.to_json)

    stub_request(:get, "https://tamu-dining-62fbd726fd19.herokuapp.com/administrators/#{user.email}/validate_admin").
      with(
        headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Host'=>'tamu-dining-62fbd726fd19.herokuapp.com',
          'User-Agent'=>'Ruby'
        }
      ).
      to_return(status: 200, body: {valid: true}.to_json, headers: {})


  @user = user
  @id = user.id
  @name = user.name
  @email = user.email
  @credits = user.credits
  @user_type = user.user_type
  @uid = user.uid
  @user_school = CreditPool.find_by(email_suffix: @user.email.partition('@').last)
  OmniAuth.config.test_mode = true
  OmniAuth.config.add_mock(
    :google_oauth2,
    uid: user.id,
    info: { email: user.email }
  )
  click_on 'Login with Google'
end

And('I am on the admin page') do
    visit admin_home_path
end

And('I enter {string} credits in the update-credits field') do |credits| 
    fill_in "credit-amount", with: credits
end

Then('the school should have {int} credits in the pool') do |credits|
    expect(page).to have_content("Credits in Pool: #{credits}")
end