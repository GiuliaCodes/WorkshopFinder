Feature: Book a spot
  As a Registered User
  So that I can become a Partecipant
  I want to click a partecipate link in the workshop page

Background:
  Given an organizer
  Given a workshop organized by organizer
  

Scenario: User books a spot
  Given a user
  Given I am authenticated as user
  And I am on the workshops page
  When I follow first "Show" link for a workshop
  Then I should see "WorkshopName"
  When I follow "Book your spot"
  Then I should see "Book your spot for: WorkshopName"
  When I click "Reserve me a spot"
  Then I should see "Booking was successfully created."
  And I should see "This is your booking"
  And I should have role(s): "user partecipant"

Scenario: User cannot book a spot for the same workshop twice
  Given a partecipant
  Given I am authenticated as partecipant
  Given I booked a spot for the workshop
  Given I am on the workshops page
  When I follow first "Show" link for a workshop
  Then I should see "WorkshopName"
  Then I should not see link "Book your spot"
  Then I should see link "Show your booking"