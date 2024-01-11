Given('the number of available credits is {int}') do |num_credits|
end

When('I go to the request credits page') do
  visit "/users/#{@uin}/receive"
end

Then('I should be on the profile page') do
  visit "/users/#{@uin}"
end

Then("I should have {int} credits") do |num_credits|
  expect(page).to have_content('Number of credits: #{num_credits}')
end