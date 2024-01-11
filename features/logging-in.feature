Feature: logging in

    As a student
    In order to get access to my account
    I want the ability to sign into Bytes using my verified school email address

Scenario: user logs in with TAMU email
    Given the user is on the Google login page
    When the user logs in with tamu.edu email
    Then the user should be logged in successfully