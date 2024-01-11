Feature: receive meal credits 

  As a student in need of credits
  So that I can get aid in getting food
  I want a way to request credits

Background: Credits in database
  Given the following credit pools exist:
  |   credits   |
  |   50        |

Scenario: requesting for credits when there are enough available
  Given that I am logged in an account with 10 credits
  When  I go to the "receive" page
  And   I fill in "Number of Credits" with 10
  And   I press the "Request" button
  Then  I should see "10 Credits received"
  And   I should be on the profile page
  And   I should have 20 credits

Scenario: requesting more credits then there are available
  Given that I am logged in an account with 10 credits
  When  I go to the "receive" page
  And   the number of available credits is 50
  And   I currently have 10 credits
  When  I fill in "Number of Credits" with 80
  And   I press the "Request" button
  Then  I should see "Not enough credits available"
  And   I should be on the receive page
  And   the number of available credits is 50
  And   I currently have 10 credits
