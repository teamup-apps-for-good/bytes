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

Given('I have successfully scheduled a recurring meeting') do
  fill_in 'meeting[date]', with: '2024-03-11'
  fill_in 'meeting[time]', with: '12:00 PM'
  fill_in 'meeting[location]', with: 'Conference Room'
  checkbox = find("#newRecurring")
  checkbox.click
  click_button "Schedule Meeting"
end

Given('there is a meeting listed') do
  Meeting.create(uid: '3242985', date: '2024-03-11', time: '12:00 PM', location: 'Conference Room', accepted: false, accepted_uid: nil)
end

Given('I have an accepted meeting listed') do
  Meeting.create(uid: '3242985', date: '2024-03-11', time: '12:00 PM', location: 'Conference Room', accepted: true, accepted_uid: '123456789')
end

Given('I as a recipient have an accepted meeting listed') do
  Meeting.create(uid: '3242985', date: '2024-03-11', time: '12:00 PM', location: 'Conference Room', accepted: true, accepted_uid: '11112222')
end



Given('I have an accepted recurring meeting listed') do
  Meeting.create(uid: '3242985', date: '2024-03-11', time: '12:00 PM', location: 'Conference Room', accepted: true, accepted_uid: '123456789', recurring: true)
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

When('I edit a meeting\'s info') do
  fill_in 'meeting[date]', with: '2024-03-12'
  fill_in 'meeting[time]', with: '12:30 PM'
  fill_in 'meeting[location]', with: 'Conference Room 2'
  click_button 'Confirm Changes'
end

Then('I should see the new meeting in the meetings list') do
  visit meetings_path
  expect(page).to have_content('03/11/2024')
  expect(page).to have_content('12:00 PM')
  expect(page).to have_content('Conference Room')
end

Then('I should not see the meeting in the meetings list') do
  visit meetings_path
  expect(page).to have_no_content('03/11/2024')
  expect(page).to have_no_content('12:00 PM')
  expect(page).to have_no_content('Conference Room')
end

Then('I should see the meeting in my meetings') do
  table = find("#yourMeetingsTable")
  expect(table).to have_content('03/11/2024')
  expect(table).to have_content('12:00 PM')
  expect(table).to have_content('Conference Room')
end

Then('I should see the meeting listed publicly') do
  table = find("#publicMeetingsTable")
  expect(table).to have_content('03/11/2024')
  expect(table).to have_content('12:00 PM')
  expect(table).to have_content('Conference Room')
end

Then('I should see the {string} button') do |string|
  table = find("#publicMeetingsTable")
  expect(table).to have_content(string)
end

Then('I should see the fields are autofilled with my meeting\'s info') do
  expect(page).to have_field('meeting_date', with: '2024-03-11')
  expect(page).to have_field('meeting_time', with: '12:00:00.000')
  expect(page).to have_field('meeting_location', with: 'Conference Room')
end

Then('the meeting should have the updated information') do
  table = find("#publicMeetingsTable")
  expect(table).to have_content('03/12/2024')
  expect(table).to have_content('12:30 PM')
  expect(table).to have_content('Conference Room 2')
end

Then('I should not see the {string} button') do |string|
  expect(page).to have_no_content('Edit')
end