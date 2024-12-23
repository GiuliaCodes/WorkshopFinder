Feature: admin abilities
    As an admin
    So that I can see all the users
    I want to have a link to all users in my profile page 

    As an admin
    So that I can remove a user
    I want to have an option to delete an account in the users list

    As an admin 
    So that I can remove a workshop
    I want to have a link in the workshop details

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

Scenario: an admin can destroy workshops
    Given an organizer
    Given an admin
    Given I am authenticated as admin
    Given a workshop list
    And I am on the workshops page
    Then I should see button "Destroy"

Scenario: an user cannot destroy workshops
    Given a user
    Given an organizer
    Given I am authenticated as user
    Given a workshop list
    And I am on the workshops page
    Then I should not see button "Destroy"
