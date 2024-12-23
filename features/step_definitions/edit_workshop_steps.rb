Given('a workshop organized by organizer') do
    #workshop = Workshop.create!(:name=> "WorkshopName", :date=>"2026-01-01", :max_partecipants => 2, :organizer_id => 3 )
    workshop = Workshop.create!(:name=> "WorkshopName", :date=> Date.tomorrow.to_s , :max_partecipants => 2, :organizer_id => 3 )
end

Given('I am on the workshop page') do
    workshop=Workshop.find_by(name: "WorkshopName")
    visit workshop_path(workshop.id)
end

Given('I am authenticated as another organizer') do
    u = User.create!(:username=> "anotherorganizer", :email=>"organizer@another.com", :password => "organizerpassword", :roles_mask => 5 )
    visit "/users/sign_in"
    fill_in "Email", with: "organizer@another.com"
    fill_in "Password", with: "organizerpassword"
    click_button "Log in"
end