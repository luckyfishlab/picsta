Feature: User signs up with stripe
  Note: you must have stripe setup with silver plan
  for these tests to run correctly.

  Background:
    Given: I am on the home page
     And I am logged in
     And The "silver" plan exists
     And I visit the "/thanks" page
    When I click the link "Subscribe"
    Then I should see "Choose a subscription plan"

  @javascript
  Scenario: With valid card data
    Given I fill in the following:
      | user_name               | Testy McUserson   |
      | Credit Card Number         | 4242424242424242  |
      | card_code                  | 111               |
    Then I select "5 - May" as the "month"
    And I select "2015" as the "year"
    When I press "Submit"
    #Then I should be on the "content silver" page
    Then I should see a successful sign up message

  @javascript
  Scenario: With invalid card number
    Given I fill in the following:
      | user_name               | Testy McBadCard   |
      | Credit Card Number         | 5555555555555     |
      | card_code                  | 111               |
    Then I select "1 - January" as the "month"
    And I select "2016" as the "year"
    When I press "Submit"
    #Then I should be on the new silver user registration page
    And I should see "Your card number is incorrect"

  @javascript
  Scenario: With invalid card security code
    Given I fill in the following:
      | user_name               | Testy McBadCode   |
      | Credit Card Number         | 4242424242424242  |
      | card_code                  | 6                 |
    Then I select "10 - October" as the "month"
    And I select "2016" as the "year"
    When I press "Submit"
    #Then I should be on the new silver user registration page
    And I should see "Your card's security code is invalid"

    @javascript
    Scenario: With declined card
      Given I fill in the following:
        | user_name               | Testy McDecline   |
        | Credit Card Number         | 4000000000000002  |
        | card_code                  | 111               |
      Then I select "10 - October" as the "month"
      And I select "2016" as the "year"
      When I press "Submit"
      Then I should be on the "user registration" page
      And I should see "declined"

