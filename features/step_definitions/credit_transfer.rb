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
    
    #visit "/my_profile"
    #expect(page).to have_content(string)
    #expect(page).to have_content(string2)
    @uin = string2
    visit "/users/#{@uin}/transfer"
    expect(page).to have_current_path "/users/#{string2}/transfer"
end

When('I go to the {string} page') do |string|
    visit "/users/#{@uin}/#{string}"
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