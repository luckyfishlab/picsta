Feature: Manage Albums
  As a registered user of the website
  I want to manage my albums
  so I can keep them organized

  Scenario: I create an album
    Given I am logged in
    When I create an album
    Then I should see an created message

  Scenario: I can see my albums
    Given I am logged in
    And I create an album
    When I select the album
    Then I should see the album contents

  Scenario: Steve can not access Joe's albums
    Given I am logged in as "Steve"
    Given I create the album "Test Album"
     And I sign out
     And I am logged in as "Joe"
    When I try the last URL
    Then I should see an error

