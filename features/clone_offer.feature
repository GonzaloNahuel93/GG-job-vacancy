Feature: Clone Offer
  In order to post a new offer
  As a offerer
  I want to clone an existing offer

  Background:
    Given I am logged in as job offerer
  	And There is at least one existing offer posted by me

  Scenario: Clone an existing offer
    Given I am watching the Ruby-Padrino offer
    When I press the clone button for my offer
    Then I should be able to edit a copy of it 

  Scenario: Clone an existing offer and posting it with the same name as another offer posted by me
    Given I have previously created another offer named "Programador Python"
    And I am editing my cloned offer
    When I try to post the cloned offer naming it "Programador Python"
    Then I should see the error 'You already have an offer with the same title'
