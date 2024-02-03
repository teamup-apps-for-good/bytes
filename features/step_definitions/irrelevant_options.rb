Given('I am a {string} profile') do |string|
    expect(@user.user_type).to eq string
end
  
Then('I should not see {string}') do |string|
    expect(page).not_to have_content(string)
end
