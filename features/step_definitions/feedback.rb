# frozen_string_literal: true

Then('I should be on the user-feedback page') do
  expect(page).to have_current_path(new_feedback_path)
end

Given('I am on the user-feedback page') do
  visit new_feedback_path
end
