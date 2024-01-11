Given('the following users exist:') do |table|
    table.hashes.each do |user|
        User.create user
    end
end

Given('the following credit pools exist:') do |table|
    table.hashes.each do |pool|
        CreditPool.create pool
    end
end

Given('I am a {string} account with uin {string}') do |string, string2|
    @user = User.find_by(uin: string2)
    @uin = @user.uin
    @email = @user.email
    @name = @user.name
    @credits = @user.credits
    @user_type = @user.user_type
end

When('I go to the {string} page') do |string|
    if string == "transfer"
        visit "/users/#{@uin}/#{string}"
    end
    
    if string == "profile"
        visit "/users/#{@id}"
        current_path = "/users/#{@id}"
        expect(current_path).to eq("/users/#{@id}")
    end
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