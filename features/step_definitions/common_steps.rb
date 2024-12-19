Given(/^I am on the home page$/) do
    visit "/"
end

Given('I am on the workshops page') do
  visit "/workshops"
end

Given('I am on list of users page') do
  visit "/users"
end

When('I follow {string}') do |string|
  click_link string
end

When('I click {string}') do |string|
  click_button string
end

When('I fill {string} with {string}') do |string1, string2|
  fill_in string1, with: string2
end

Then('I should see {string}') do |string|
  #page.has_text?(text)
  expect(page).to have_content(string)
end

Then('I should not see {string}') do |string|
  expect(page).not_to have_content(string)
end

Then(/^I should see link "(.*?)"$/) do |arg1|
  expect(page).to have_link(text:/\A#{arg1}\Z/)
end

Then(/^I should not see link "(.*?)"$/) do |arg1|
  expect(page).not_to have_link(text:/\A#{arg1}\Z/)
end

Then('I should see button {string}') do |string|
  expect(page).to have_button string
end

Then('I should not see button {string}') do |string|
  expect(page).not_to have_button string
end

  