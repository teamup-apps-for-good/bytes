Given('I am on the new meeting page') do
  visit new_meeting_path
end

Given('I am on the meetings page') do
  visit meetings_path
end

Given('I have successfully scheduled a meeting') do
  fill_in 'meeting[date]', with: '2024-03-11'
  fill_in 'meeting[time]', with: '12:00 PM'
  fill_in 'meeting[location]', with: 'Conference Room'
  click_button "Schedule Meeting"
end

When('I fill in the meeting form with valid details') do
  fill_in 'meeting[date]', with: '2024-03-11'
  fill_in 'meeting[time]', with: '12:00 PM'
  fill_in 'meeting[location]', with: 'Conference Room'
end

When('I fill in the meeting form without date') do
  fill_in 'meeting[time]', with: '12:00 PM'
  fill_in 'meeting[location]', with: 'Conference Room'
end

When('I fill in the meeting form without time') do
  fill_in 'meeting[date]', with: '2024-03-11'
  fill_in 'meeting[location]', with: 'Conference Room'
end

When('I fill in the meeting form without location') do
  fill_in 'meeting[date]', with: '2024-03-11'
  fill_in 'meeting[time]', with: '12:00 PM'
end

Then('I should see the new meeting in the meetings list') do
  visit meetings_path
  expect(page).to have_content('2024-03-11')
  expect(page).to have_content('12:00:00 UTC')
  expect(page).to have_content('Conference Room')
end

Then('I should not see the meeting in the meetings list') do
  visit meetings_path
  expect(page).to have_no_content('2024-03-11')
  expect(page).to have_no_content('12:00:00 UTC')
  expect(page).to have_no_content('Conference Room')
end
