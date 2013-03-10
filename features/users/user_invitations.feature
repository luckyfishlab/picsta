Feature: Invite user
  As a subscriber to the site
  I should be able to invite other users to the site
  so that they can interact with my albums

  Scenario: Invite someone
    Given I am logged in as "Steve" as a "subscriber"
     When I invite someone
    Then "invited@example.com" should receive 1 emails

  Scenario: Invitation leads to registration page
    Given I am logged in as "Steve" as a "subscriber"
    And I invite someone
    And I sign out
    When "invited@example.com" opens the email
    When I follow "Accept invitation" in the email
    Then I should see "Complete your registration"


  Scenario: Accept invitation with invalid credentials
    Given I am logged in as "Steve" as a "subscriber"
    And I invite someone
    And I sign out
    And "invited@example.com" opens the email
    And I follow "Accept invitation" in the email
    When I register with invalid credentials
   Then I should see "errors"

  Scenario: Accept invitation with valid credentials
    Given The viewer role exist
    Given I am logged in as "Steve" as a "subscriber"
    And I invite someone
    And I sign out
    And "invited@example.com" opens the email
    And I follow "Accept invitation" in the email
    When I register with valid credentials
    Then I should see "Your password was set successfully. You are now signed in."
    And I am a viewer
