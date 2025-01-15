Feature: sign in
    As a registered user
    So that I can access the site functionalities
    I want to be able to sign in with my e-mail

Scenario: user logs in with a user role
    Given a user
    Given I am on the home page
    When I follow "Sign in"
    And I fill "Email" with "user@mail.com"
    And I fill "Password" with "userpassword"
    And I click "Log in"
    Then I should see "Welcome, username"
    And I should have role(s): "user"


Scenario: failed log in
    Given I am on the home page
    When I follow "Sign in"
    And I fill "Email" with "another@mail.com"
    And I fill "Password" with "password"
    And I click "Log in"
    Then I should see "Invalid Email or password."

Scenario: user logs in with an admin role
    Given an admin
    Given I am authenticated as admin
    Then I should have role(s): "admin user"

Scenario: user logs in with a partecipant role
    Given a partecipant
    Given I am authenticated as partecipant
    Then I should have role(s): "user partecipant"

Scenario: user logs in with a organizer role
    Given an organizer
    Given I am authenticated as organizer
    Then I should have role(s): "user organizer"

