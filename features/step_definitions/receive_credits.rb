And('I am on the {string} page') do |string|
  visit "/users/#{@user_id}/#{string}"
end

And('I fill in {string} with {int}') do |label, value|
  fill_in label, with: value
end

Then('I should be on the profile page') do
  visit "/users/#{@user_id}"
end

And('I should see {string}') do |string|
  expect(page).to have_content(string)
end

Then('I should have {int} credits') do |num_credits|
  expect(page).to have_content('Number of credits: #{num_credits}')
end

# steps for second receive_credit scenario

And('the number of available credits is {int}') do |int|
  expect(page).to have_content('Number of credits available in pool: #{int}')
end

And('I currently have {int} credits') do |int|
  expect(page).to have_content('You currently have #{int} credits')
end