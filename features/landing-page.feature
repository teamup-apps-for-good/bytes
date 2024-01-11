Feature: Landing page

    As a visitor of the website,
    In order to learn about the website and sign-in,
    I want a landing page that gives me information about the website, vision of the project, and how to join

Scenario: landing page displays basic information
    Given I am on the landing page of the site
    Then I should see 'BYTES' on the landing page
    And I should see 'Login with Google' on the landing page