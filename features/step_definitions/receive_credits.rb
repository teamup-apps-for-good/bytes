Given('the number of available credits is {int}') do |num_credits|
end

When('I go to the request credits page') do
  visit "/users/#{@uin}/receive"
end

Then ('I should be on the profile page') do
  visit "/users/#{@uin}"
end