# frozen_string_literal: true

Given('I am not logged in') do
    expect(@user).to eq nil
end
  
Given('I am on the home page') do
    visit('/')
end

Then('I should see a valid metric displayed on screen') do
    pending
end
  