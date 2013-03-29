Feature: Manage Albums
  As a registered user of the website
  I want to manage my albums
  so I can keep them organized

  Scenario: I create an album
    Given I am logged in as "Steve" as a "subscriber"
    When I create an album
    Then I should see an created message

  Scenario: I can see my albums
    Given I am logged in as "Steve" as a "subscriber"
    And I create an album
    When I select the album
    Then I should see the album contents

  Scenario: Invited user can access subscriber's albums
    Given I am logged in as "Steve" as a "subscriber"
    Given I create the album "Test Album"
    And I invite someone
    And I sign out
    And "invited@example.com" opens the email
    And I follow "Accept invitation" in the email
    And I register with valid credentials
    When I list albums
    Then I should see the album "Test Album"

  Scenario: I can't see other subscriber's albums
    Given I am logged in as "Steve" as a "subscriber"
    Given I create the album "Test Album"
    And I sign out
    Given I am logged in as "jeff" as a "subscriber"
    Given I create the album "Joe Album"
    And I visit the album "Joe Album"
    When I list albums
    Then I should not see the "Test Album" link
