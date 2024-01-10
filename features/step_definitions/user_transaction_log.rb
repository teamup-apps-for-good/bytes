Given('the following transactions exist:') do |table|
  table.hashes.each do |transaction|
    Transaction.create transaction
  end
end

Given('I am logged in as a donor') do
  pending # Write code here that turns the phrase above into concrete actions
end

Given('I have made a donation') do
  pending # Write code here that turns the phrase above into concrete actions
end

When('I go to the {string} page') do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

Then('I should see my donations') do
  pending # Write code here that turns the phrase above into concrete actions
end

Given('I am logged in as a recipient') do
  pending # Write code here that turns the phrase above into concrete actions
end

Given('I have received a donation') do
  pending # Write code here that turns the phrase above into concrete actions
end

Then('I should see my received donations') do
  pending # Write code here that turns the phrase above into concrete actions
end
