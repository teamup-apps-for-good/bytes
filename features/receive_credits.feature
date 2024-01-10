Feature: receive meal credits 

  As a student in need of credits
  So that I can get aid in getting food
  I want a way to request credits

Background: credits available in pool to receive

  Given the following movies exist:
  | uin      | name         | email            | credits | type   | date_joined |
  | 12345678 | Sponge Bob   | sponge@tamu.edu  |      60 | donor  |  1977-05-26 |
  | 22223333 | Squid Ward   | patrick@tamu.edu |      50 | donor  |  1978-02-14 |
  | 33334444 | Patrick Star | squid@tamu.edu   |       5 | loaner |  1979-08-02 |
  | 44445555 | Eugene Krabs | krabs@tamu.edu   |      10 | loaner |  1967-11-31 |

Scenario: requesting for credits when there are some available
  Given the number of available credits is greater than 20
  And   I currently have 10 credits
  When  I go to the request credits page
  And   I fill in "Number of Credits" with 10
  And   I press "Get Credits"
  Then  I should be on the profile page
  And   I should see "10 Credits received"
  And   I should have 20 credits

Scenario: requesting more credits then there are available
  Given the number of available credits is 5
  And   I currently have 10 credits
  When  I go to the request credits page
  And   I fill in "Number of Credits" with 10
  And   I press "Get Credits"
  Then  I should see "Error not enough credits available"
  And   I should have 10 credits
