Given('that I am logged in') do
  visit('/users')
end

When('I am on the home page') do
  visit root_path
end

Then('I should be logged out succesfully') do
  expect(page).to have_content('Login')
end

When('the user fills in {string} for {string}') do |string, string2|
  fill_in string2, with: string
end

When('the user presses {string}') do |string|
    click_button string
end

