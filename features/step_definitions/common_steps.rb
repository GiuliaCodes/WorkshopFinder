Given(/^I am on the home page$/) do
    visit "/"
end

Then('I should see {string}') do |string|
  #page.has_text?(text)
  expect(page).to have_content(string)
end

Given(/^I am authenticated as user$/) do
  u = User.create!(:username=> "username", :email=>"user@mail.com", :password => "userpassword", :roles_mask => 1 )
  visit "/users/sign_in"
  fill_in "Email", with: "user@mail.com"
  fill_in "Password", with: "userpassword"
  click_button "Log in"
  expect(page).to have_text("Welcome, username")
  expect(u.roles).to include(:user)
end

Given(/^I am authenticated as admin$/) do
  u = User.create!(:username=> "adminname", :email=>"admin@mail.com", :password => "adminpassword", :roles_mask => 8 )
  visit "/users/sign_in"
  fill_in "Email", with: "admin@mail.com"
  fill_in "Password", with: "adminpassword"
  click_button "Log in"
  expect(page).to have_current_path(user_path(u.id))
  expect(page).to have_text("Welcome, adminname")
  expect(u.roles).to include(:admin)
end

Given(/^I am authenticated as organizer$/) do
  u = User.create!(:username=> "organizername", :email=>"organizer@mail.com", :password => "organizerpassword", :roles_mask => 4 )
  visit "/users/sign_in"
  fill_in "Email", with: "organizer@mail.com"
  fill_in "Password", with: "organizerpassword"
  click_button "Log in"
  expect(page).to have_current_path(user_path(u.id))
  expect(page).to have_text("Welcome, organizername")
  expect(u.roles).to include(:organizer)
end

Given(/^I am authenticated as partecipant$/) do
  u = User.create!(:username=> "partecipantname", :email=>"partecipant@mail.com", :password => "partecipantpassword", :roles_mask => 2 )
  visit "/users/sign_in"
  fill_in "Email", with: "partecipant@mail.com"
  fill_in "Password", with: "partecipantpassword"
  click_button "Log in"
  expect(page).to have_current_path(user_path(u.id))
  expect(page).to have_text("Welcome, partecipantname")
  expect(u.roles).to include(:partecipant)
end

Then(/^I should see link "(.*?)"$/) do |arg1|
  expect(page).to have_link(text:/\A#{arg1}\Z/)
end

Then(/^I should not see link "(.*?)"$/) do |arg1|
  expect(page).not_to have_link(text:/\A#{arg1}\Z/)
end
  