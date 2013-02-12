Feature: Manage images
  As an album owner
  I want to manage my images
  so that I can control the images I share with other users

  Scenario: I upload an image
    Given I am logged in as "Steve" as a "subscriber"
    And I create the album "uploads"
    And I visit the album "uploads"
    And I want to add images to the album
    When I upload an image
    Then I see a successful add image message

  Scenario: I delete an image
    Given I am logged in as "Steve" as a "subscriber"
    And I create the album "uploads"
    And I visit the album "uploads"
    And I want to add images to the album
    And I upload an image
    And I click on the image
    When I click on remove image
    Then I see a successful delete image message
