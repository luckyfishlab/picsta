Feature: Edit subscription
  As a site subscriber
  I want to modify my subscription
  So that I may quit the site or get different resource levels

  Background:
    Given The "silver" plan exists
    Given The "gold" plan exists
    Given The "platinum" plan exists

  Scenario: Plan is visible
    Given I am logged in as "Steve" as a "subscriber"
    #Given I am subscribed to the "silver" plan
     When I click the link "Edit account"
     Then I see I am subscribed to "silver" plan

  @javascript
  Scenario: Change from silver to gold
    Given I am logged in as "Steve" as a "subscriber"
     And I click the link "Edit account"
    And I click the link "Modify Plan"
    And I see the subscription option "gold"
    When I change to the "gold" plan
     And I press "Change Plan"
    Then I see I am subscribed to "gold" plan




