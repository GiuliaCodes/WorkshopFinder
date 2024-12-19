Given('an admin') do
  @admin = User.create!(:username=> "adminname", :email=>"admin@mail.com", :password => "adminpassword", :roles_mask => 9 )
end

Given(/^I am authenticated as admin$/) do
  visit "/users/sign_in"
  fill_in "Email", with: "admin@mail.com"
  fill_in "Password", with: "adminpassword"
  click_button "Log in"
  #expect(page).to have_current_path(user_path(@admin.id))
  expect(page).to have_text("Welcome, adminname")
end

Given('a user') do
  @user = User.create!(:username=> "username", :email=>"user@mail.com", :password => "userpassword", :roles_mask => 1 )
end

Given(/^I am authenticated as user$/) do
  visit "/users/sign_in"
  fill_in "Email", with: "user@mail.com"
  fill_in "Password", with: "userpassword"
  click_button "Log in"
  #expect(page).to have_current_path(user_path(@user.id))
  expect(page).to have_text("Welcome, username")
end

Given("a partecipant") do
  @partecipant = User.create!(:username=> "partecipantname", :email=>"partecipant@mail.com", :password => "partecipantpassword", :roles_mask => 3 )
end 

Given(/^I am authenticated as partecipant$/) do
  visit "/users/sign_in"
  fill_in "Email", with: "partecipant@mail.com"
  fill_in "Password", with: "partecipantpassword"
  click_button "Log in"
  #expect(page).to have_current_path(user_path(@partecipant.id))
  expect(page).to have_text("Welcome, partecipantname")
end

Given("an organizer") do
  @organizer = User.create!(:id=>3, :username=> "organizername", :email=>"organizer@mail.com", :password => "organizerpassword", :roles_mask => 5 )
end 

Given(/^I am authenticated as organizer$/) do
  visit "/users/sign_in"
  fill_in "Email", with: "organizer@mail.com"
  fill_in "Password", with: "organizerpassword"
  click_button "Log in"
  #expect(page).to have_current_path(user_path(@organizer.id))
  expect(page).to have_text("Welcome, organizername")
end

Given("I am on user {string} page") do |string|
  u=User.find_by(username: string)
  visit user_path(u.id)
end

Then('I should have role\(s): {string}') do |string|
  expect(page).to have_text("Your Roles: "+string)
end