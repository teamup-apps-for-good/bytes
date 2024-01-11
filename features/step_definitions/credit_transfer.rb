Given('the following users exist:') do |table|
    User.destroy_all
    table.hashes.each do |user|
        User.create user
    end
end

Given('the following credit pools exist:') do |table|
    CreditPool.destroy_all
    table.hashes.each do |pool|
        CreditPool.create pool
    end
end


Given('I am a {string} account with uin {string}') do |string, string2|
    visit root_path
    user = User.create(name: 'John', uin: string2, email: 'j@tamu.edu', credits: '50', user_type: string, date_joined: '01/01/2022')
    @user = user
    @id = user.id
    @name = user.name
    @email = user.email
    @credits = user.credits
    @user_type = user.user_type
    @uin = user.uin
    OmniAuth.config.test_mode = true
    OmniAuth.config.add_mock(
        :google_oauth2,
        uid: user.id,
        info: { email: user.email }
    )
    click_on "Login with Google"

    
end

When('I go to the transfer page') do 
    visit "/users/#{@user.id}/transfer"
end

When('I fill out {string} with {string} credit to transfer') do |string,string2|
    fill_in string, with: string2
end

When('I press the {string} button') do |string|
    click_button string
end

Then('I should see a {string} popup') do |string|
    expect(page).to have_content(string)
end

Then('I should see {string} credit removed from my account') do |string|
    expect(page).to have_content(string)
end

Then('I should see {string} credits removed from my account') do |string|

end