Feature: Leave a Review
    As a Partecipant
    So that I can leave a review
    I want to click the Review link in the workshop page

Scenario: A partecipant can leave review for a booked workshop
    Given a partecipant
    Given I am authenticated as partecipant
    Given an organizer
    Given a workshop in the past
    Given I booked a spot for the workshop   
    And I am on the workshop page
    Then I should see link "Leave a Review"
    When I follow "Leave a Review"
    Then I should see "Add a review to WorkshopName"
    When I write "Great!"
    And I click "Add Review"
    Then I should see "Review was successfully created"
    And I should see "Description: Great!"

Scenario: A partecipant cannot leave review for a booked workshop in the future
    Given a partecipant
    Given I am authenticated as partecipant
    Given an organizer
    Given a workshop organized by organizer
    Given I booked a spot for the workshop   
    And I am on the workshop page
    Then I should see link "Leave a Review"
    When I follow "Leave a Review"
    Then I should see "It's too soon to review this workshop."

Scenario: A user who is not partecipant cannot review workshops
    Given a user
    Given I am authenticated as user
    Given an organizer
    Given a workshop in the past
    And I am on the workshop page
    Then I should not see link "Leave a Review"
