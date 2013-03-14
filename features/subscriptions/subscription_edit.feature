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

  Scenario: Change from silver to gold
    Given I am logged in as "Steve" as a "subscriber"
    #Given I am subscribed to the "silver" plan
     And I click the link "Edit account"
    When I click the link "Modify Plan"
    Then I see the subsciption options

