Feature: edit workshop
    As an organizer 
    So that I can edit my workshop info
    I want to click an edit link in the workshop page

Background: 
    Given an organizer
    And a workshop organized by organizer
    
Scenario: an organizer can edit own workshop
    Given I am authenticated as organizer
    Given I am on the workshop page
    Then I should see link "Edit"
    
Scenario: an organizer cannot edit another organizer's workshops
    Given I am authenticated as another organizer
    Given I am on the workshop page
    Then I should not see link "Edit"

Scenario: a user who is not an organizer cannot edit workshops
    Given a user
    Given I am authenticated as user
    Given I am on the workshop page
    Then I should not see link "Edit"

Scenario: an organizer edits own workshop
    Given I am authenticated as organizer
    And I am on the workshop page
    When I follow "Edit"
    And I fill "Location" with "Edificio Marco Polo, Sapienza, Roma"
    And I click "Update Workshop"
    Then I should see "Workshop was successfully updated"
    And I should see "Location: Edificio Marco Polo"
    
