Feature: School View

  As a student using Bytes,
  I want to be able to see my school’s logo even if I’m not from Texas A&M,
  So that I can have a better, more personal, user experience.

Background: Schools in database

  Given the following schools exist:
  |     name              |    domain   |      logo             |
  | Texas A&M University  |  tamu.edu   |  tamu-logo-words.png  |
  | University of Houston |  uh.edu     |  background.png       |
  | Rice University       |  ru.edu     |  background2.png      |

Scenario: Can see all schools
  Given I am on the login page
  And I am logged in
  And I am on the schools page
  Then I should see all of the schools

Scenario: Can see a single school
  Given I am on the login page
  And I am logged in
  And I am on the school page for "Texas A&M University"
  Then I should see "Texas A&M University"

Scenario: Deleteing a school
  Given I am on the login page
  And I am logged in
  And I am on the school page for "Texas A&M University"
  Then I press the "Delete" button
  Then I should see "Texas A&M University deleted."

Scenario: Adding a new school
  Given I am on the login page
  And I am logged in
  And I am on the new school page
  When I fill in the form with valid school information
  Then I press the "Create School" button
  Then I should see "Test was successfully added."
  And I should be redirected to the schools index page