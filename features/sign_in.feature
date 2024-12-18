Feature: a user can sign in
    As a registered user
    So that I can access the site functionalities
    I want to be able to sign in with my e-mail

Scenario: user logs in with a user role
    Given I am a registered user
    And I have the user role
    Given I am on the home page
    When I click the "Sign in" button
    And I fill "Email" with "user@mail.com"
    And I fill "Password" with "userpassword"
    And I click "Log in"
    Then I should see my profile page
    And I should see my "user" role

Scenario: failed log in
    Given I am on the home page
    When I click the "Sign in" button
    And I fill "Email" with "another@mail.com"
    And I fill "Password" with "password"
    And I click "Log in"
    Then I should see "Invalid Email or password."

Scenario: user logs in with an admin role
    Given I am authenticated as admin
    Then I should see my "admin" role

Scenario: user logs in with a partecipant role
    Given I am authenticated as partecipant
    Then I should see my "partecipant" role

Scenario: user logs in with a organizer role
    Given I am authenticated as organizer
    Then I should see my "organizer" role

