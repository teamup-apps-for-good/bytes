Feature: api call

    As a student with excess credits,
    I want to accurately see how many credits I have,
    so that I can know how many credits I want to donate.

    As a food insecure student,
    I want my credits to be promptly updated when I receive a donation,
    so that I can use the credits for my meals right away.

Scenario: api call for user credits
    Given a student with uin 111111111 exists
    When I request their meal plan information from tamu-dining
    Then I should send an api request to tamu-dining for a user with uin 111111111
    And I should recieve a JSON object with the first name, last name, uin, email, and credits

Scenario: api call to update user credits
    Given that I am logged into an account with 10 credits and uin 111111111
    When  I go to the "receive" page
    And   I fill in "Number of Credits" with 10
    And   I press the "Request" button
    Then  an api request should be sent to tamu-dining to update the credits for uin 111111111
    And   I should recieve a JSON object with the user's updated credits
    

