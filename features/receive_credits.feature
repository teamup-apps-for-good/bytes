Feature: receive meal credits 

  As a student in need of credits
  So that I can get aid in getting food
  I want a way to request credits

Background: Credits in database
  Given the following credit pools exist:
  |   credits   |   email_suffix   |   id_name   |   school_name   |
  |      50      |     tamu.edu     |     UIN     |      TAMU       |

Scenario: requesting for credits when there are enough available
  Given that I am logged in an account with 9 credits
  When  I go to the "receive" page
  And   I fill in "Number of Credits" with "10"
  And   I press the "Request" button as this user
  Then  I should see CONFIRMATION Sucessfully recieved 10 credits!
  And   I should be on the profile page
  And   I should have 19 credits

Scenario: requesting more credits then there are available
  Given that I am logged in an account with 9 credits
  When  I go to the "receive" page
  And   the number of available credits is 50
  And   I currently have 9 credits
  When  I fill in "Number of Credits" with "80"
  And   I press the "Request" button
  Then  I should see "Not enough credits available"
  And   I should be on the receive page
  And   the number of available credits is 50
  And   I currently have 9 credits
