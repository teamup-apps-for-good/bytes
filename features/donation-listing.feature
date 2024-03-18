Feature: Donation Listing

    As a food insecure student,
    I want a way to see and accept in-person donation postings,
    So that I can request an in-person donation that best fits my schedule.

Background: Users in database

    Given the following users exist:
    |   name   |   uid   |    email     |  user_type   |
    |   John   | 123456  |  j@tamu.edu  |    donor     |
    |   Todd   | 324567  |  t@tamu.edu  |   recipient  |
    |   Jim    | 124124  |  ji@tamu.edu |    donor     |

    Given the following credit pools exist:
    |   credits   |   email_suffix   |   id_name   |   school_name   |
    |      0      |     tamu.edu     |     UIN     |      TAMU       |

    Given the following meetings exist:
    |   uid    |     date       | time   | location | recurring |
    | 123456   | 01/01/2024     | 9:00pm | Sbisa    | false     |
    | 324567   | 01/02/2024     | 7:00pm | Zack     | false     |
    | 124124   | 01/03/2024     | 1:00pm | Hullabaloo | true     |

    Given the following schools exist:
    |     name              |    domain   |      logo             |
    | Texas A&M University  |  tamu.edu   |  tamu-logo-words.png  |
    | University of Houston |  uh.edu     |  background.png       |
    | Rice University       |  ru.edu     |  background2.png      |    

Scenario: There is a link to the meetings on the home page
    Given I am on the login page
    And I am logged in
    And I am on the home page
    Then I should see a link to the meeting page

Scenario: If meetings exist, I should see them on the meeting page
    Given I am on the login page
    And I am logged in
    And I am on the meeting page
    Then I should see meetings on the page

Scenario: If meetings don't exist, I should not see any on the meeting page
    Given I am on the login page
    And I am logged in
    And I am on the meeting page
    And There are no existing meetings
    Then I should not see any meetings on the page