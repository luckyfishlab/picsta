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

#  Scenario: Current plan is selected

  Scenario: See card details
    Given I am logged in as "Steve" as a "subscriber"
     When I click the link "Edit account"
     Then I see my card ends in "4242"

  @javascript
  Scenario: I can see the change credit form
    Given I am logged in as "Steve" as a "subscriber"
      And I click the link "Edit account"
      When I click the link "Change Card"
      Then I see the card form

  @javascript
  Scenario: I can change credit card used
    Given I am logged in as "Steve" as a "subscriber"
      And I click the link "Edit account"
      And I click the link "Change Card"
      And I see the card form
    Given I fill in the following:
      | Credit Card Number         | 4012888888881881  |
      | card_code                  | 111               |
    Then I select "5 - May" as the "month"
    And I select "2015" as the "year"
   When I press "Change Credit Card"
    Then I should see "Updated card"

