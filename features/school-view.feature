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
  And I am on the school page for tamu
  Then I should see "Texas A&M University"
