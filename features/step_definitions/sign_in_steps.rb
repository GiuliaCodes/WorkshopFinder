Given('I am a registered user') do
  @user = User.create!(:username=> "name", :email=>"user@mail.com", :password => "userpassword", :roles_mask => 1 )
end

Given('I have the user role') do
  expect(@user.roles).to include(:user)
end

When('I click the {string} button') do |string|
  click_button string
end

When('I fill {string} with {string}') do |string1, string2|
  fill_in string1, with: string2
end

When('I click {string}') do |string|
  click_button "Log in"
end

Then('I should see my profile page') do
  expect(page).to have_current_path(user_path(@user.id))
end

Then('I should see my {string} role') do |string|
  expect(page).to have_text("Your Roles: "+string)
end
