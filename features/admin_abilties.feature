Feature: admin abilities

Scenario: an admin can see all users
    Given an admin
    Given I am authenticated as admin
    Given I am on user "adminname" page
    Then I should see link "all users"

Scenario: a user who is not admin cannot see all users page
    Given a user
    Given I am authenticated as user
    Given I am on user "username" page 
    Then I should not see link "all users"

Scenario: an admin can destroy users
    Given a user
    Given an organizer
    Given a partecipant
    Given an admin
    Given I am authenticated as admin
    And I am on list of users page
    Then I should see button "Destroy"

Scenario: an user cannot destroy other users
    Given a user
    Given an organizer
    Given a partecipant
    Given an admin
    Given I am authenticated as user
    And I am on list of users page
    Then I should not see button "Destroy"