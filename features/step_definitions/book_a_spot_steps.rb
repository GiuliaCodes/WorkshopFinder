When('I follow first {string} link for a workshop') do |string|
    click_link string, match: :first
end

Given('I booked a spot for the workshop') do
    user=User.find_by( username: "partecipantname")
    workshop=Workshop.find_by( name: "WorkshopName")
    booking=Booking.create!( :user_id => user.id, :workshop_id => workshop.id)
end
  