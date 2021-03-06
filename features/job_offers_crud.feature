Feature: Job Offers CRUD
  In order to get employees
  As a job offerer
  I want to manage my offers

  Background:
    Given I am logged in as job offerer

  Scenario: Create new offer
    Given I access the new offer page
    When I fill the title with "Programmer vacancy"
	  And confirm the new offer    
    Then I should see "Offer created"
    And I should see "Programmer vacancy" in My Offers

  Scenario: Update offer
    Given I have "Programmer vacancy" offer in My Offers
    And I edit it
    And I set title to "Programmer vacancy!!!"
    And I save the modification
    Then I should see "Offer updated"
    And I should see "Programmer vacancy!!!" in My Offers

  Scenario: Edit an offer and save it with an existing title
    Given I have the Ruby Programmer and Java Programmer offers in My Offers
    And I edit the Java Programmer offer
    And I set Ruby Programmer as the new title
    And I click the "Save" button
    Then I should see the error 'You already have an offer with the same title'

  Scenario: Edit an offer and save it with the same title
    Given I have the Ruby Programmer and Java Programmer offers in My Offers
    And I edit the Java Programmer offer
    And I click the "Save" button
    Then I should not see the error 'You already have an offer with the same title'
    And I should see "Java Programmer" in My Offers

  Scenario: Confirm an offer's deletion
    Given I have "Ruby Programmer" offer in My Offers
    When I delete it
    Then I should see "Are you sure you want to delete the offer?"
