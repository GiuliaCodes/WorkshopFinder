Feature: Sort Workshops by date
    As a registered User
    So that I can sort workshops by date
    I want to click a date column in the workshop list in the homepage

Scenario: Sort workshops by date
    Given an organizer
    Given a workshop list
    Given a user
    Given I am authenticated as user
    Given I am on the workshops page
    When I follow "Sort by date"
    Then I should see "Workshop3 2026-01-01 organizername Show Workshop2 2026-01-02 organizername Show Workshop1 2026-01-03 organizername Show" 