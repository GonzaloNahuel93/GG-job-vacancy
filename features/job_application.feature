Feature: Job Application
  In order to get a job
  As a candidate
  I want to apply to an offer

  Background:
  	Given only a "Web Programmer" offer exists in the offers list

  Scenario: Apply to job offer
    Given I access the offers list page
    When I apply
    Then I should receive a mail with offerer's info

  Scenario: Apply to job offer with an invalid email address
    Given I access the offers list page
    When I click apply
    And I enter an invalid email address 
    Then I should see the error 'Please enter a valid email address'

  Scenario: Apply to job offer with all the required data
    Given I access the offers list page
    When I click apply
    Then I should be able to see "First name", "Last name", "Presentation" and "Curriculum" fields
