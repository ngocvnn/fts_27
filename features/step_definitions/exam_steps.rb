Given(/^we have categories like follow:$/) do |table|
  table.map_headers! "name" => :name
  table.hashes.each {|hash| FactoryGirl.create :category, hash}
end

When(/^I visit exam page$/) do
  visit exams_path
end

Then(/^I should see message say "(.*?)"$/) do |message|
  expect(page).to have_content message
end

Given(/^I have already signed in$/) do
  @user = FactoryGirl.create :user
  visit new_user_session_path
  fill_in "user[email]", with: @user.email
  fill_in "user[password]", with: @user.password
  click_button 'Sign in'
end

Then(/^I should see header with text "(.*?)" and button "(.*?)"$/) do |header, button|
  expect(page).to have_selector("//h1", text: header)
  expect(page).to have_selector("//input[type=submit][value=#{button}]")
end

When(/^I choose a category and click "(.*?)"$/) do |button|
  click_button button
end

Then(/^I should see an exam with "(.*?)" link$/) do |link|
  expect(@user.exams.count).to eq(1)
  expect(page).to have_selector("//a", text: link)
end