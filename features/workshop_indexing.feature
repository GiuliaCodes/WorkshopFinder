Feature: Workshop Indexing
    As a registered User
    So that I can sort workshops by date
    I want to click a date column in the workshop list in the homepage

    As a registerd user
    So that I can look workshop by city
    I want to insert the city in a search bar in the homepage

    As a registerd user
    So that I can look for workshops by category
    I want to insert the category in a search bar in the homepage

Scenario: Sort workshops by date
    Given an organizer
    Given a workshop list
    Given a user
    Given I am authenticated as user
    Given I am on the workshops page
    When I follow "Date"
    Then I should see Workshops sorted in order

Scenario: Search workshop by category
    Given an organizer
    Given a workshop list
    Given a user
    Given I am authenticated as user
    Given I am on the workshops page
    When I fill "Search by category" with "Other1"
    And I click "Search"
    Then I should see "Other1"
    Then I should not see "Other2"
    And I should not see "Other3"

Scenario: Search workshop by city
    Given an organizer
    Given a workshop list
    Given a user
    Given I am authenticated as user
    Given I am on the workshops page
    When I fill "Search by city" with "City1"
    And I click "Search"
    Then I should see "City1"
    Then I should not see "City2"
    And I should not see "City3"