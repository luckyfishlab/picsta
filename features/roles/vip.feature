Feature: VIP users
  As a site VIP
  I don't need a subscription
  So that I can upload and invite users

  Scenario: I create an album
    Given I am logged in as "Steve" as a "vip"
    When I create an album
    Then I should see an created message

  Scenario: I can see my albums
    Given I am logged in as "Steve" as a "vip"
    And I create an album
    When I select the album
    Then I should see the album contents

  Scenario: Invited user can access subscriber's albums
    Given I am logged in as "Steve" as a "vip"
    Given I create the album "Test Album"
    And I invite someone
    And I sign out
    And "invited@example.com" opens the email
    And I follow "Accept invitation" in the email
    And I register with valid credentials
    When I list albums
    Then I should see the album "Test Album"