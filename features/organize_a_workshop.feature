Feature: Create Workshop
    As a registered user
    So that I can become an organizer
    I want to create a new workshop

Scenario: User successfully creates a workshop 
    Given a user
    Given I am authenticated as user
    And I am on the workshops page
    When I follow "Organize a Workshop"
    And I fill "Name" with "Workshop Test"
    And I fill "Category" with "Other"
    And I fill "City" with "Rome"
    And I select a valid date
    And I fill "Time" with "12:00"
    And I fill "Length" with "3 hours"
    And I fill "Max partecipants" with "2"
    And I fill "Price" with "10€"
    And I fill "Location" with "Edificio Marco Polo, Sapienza, Roma"
    And I click "Create Workshop"
    Then I should see "Workshop was successfully created."
    And I should see "Workshop Test"
    And I should have role(s): "user organizer"

Scenario: Date not valid
    Given a user
    Given I am authenticated as user
    And I am on the workshops page
    When I follow "Organize a Workshop"
    And I fill "Name" with "Workshop Test"
    And I select an invalid date
    And I fill "Max partecipants" with "2"
    And I click "Create Workshop"
    Then I should see "Date must be greater than today"


Scenario: User cannot create a workshop
    Given a user
    Given I am authenticated as user
    And I am on the workshops page
    When I follow "Organize a Workshop"
    And I click "Create Workshop"
    Then I should see "Name can't be blank"
    And I should see "Max partecipants can't be blank"
    And I should see "Date must be greater than today"
