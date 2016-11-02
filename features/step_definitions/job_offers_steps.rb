When(/^I browse the default page$/) do
  visit '/'
end

Given(/^I am logged in as job offerer$/) do
  visit '/login'
  fill_in('user[email]', :with => 'offerer@test.com')
  fill_in('user[password]', :with => 'Passw0rd!')
  click_button('Login')
  page.should have_content('offerer@test.com')
end

Given(/^I access the new offer page$/) do
  visit '/job_offers/new'
  page.should have_content('Title')
end

When(/^I fill the title with "(.*?)"$/) do |offer_title|
  fill_in('job_offer[title]', :with => offer_title)
end

When(/^confirm the new offer$/) do
  click_button('Create')
end

Then(/^I should see "(.*?)" in My Offers$/) do |content|
  visit '/job_offers/my'
  page.should have_content(content)
end


Then(/^I should not see "(.*?)" in My Offers$/) do |content|
  visit '/job_offers/my'
  page.should_not have_content(content)
end

Given(/^I have "(.*?)" offer in My Offers$/) do |offer_title|
  JobOffer.all.destroy
  visit '/job_offers/new'
  fill_in('job_offer[title]', :with => offer_title)
  click_button('Create')
end

Given(/^I edit it$/) do
  click_link('Edit')
end

And(/^I delete it$/) do
  click_button('Delete')
end

Given(/^I set title to "(.*?)"$/) do |new_title|
  fill_in('job_offer[title]', :with => new_title)
end

Given(/^I save the modification$/) do
  click_button('Save')
end

#Acá escribo los steps del Escenario "Edit offer with a title of other offer"
Given(/^I have 'Programmer Ruby' and 'Programmer Java' offers in My Offers$/) do
  visit '/job_offers/new/'
  fill_in('job_offer[title]', :with => 'Programmer Ruby')
  fill_in('job_offer[location]', :with => 'Buenos Aires')
  fill_in('job_offer[description]', :with => 'I want a programmer Ruby')
  click_button('Create')

  visit '/job_offers/new/'
  fill_in('job_offer[title]', :with => 'Programmer Java')
  fill_in('job_offer[location]', :with => 'Santa Fe')
  fill_in('job_offer[description]', :with => 'I want a programmer Java')
  click_button('Create')

  page.should have_content('Programmer Ruby')
  page.should have_content('Programmer Java')
end

And(/^I edit 'Programmer Java'$/) do
  visit '/job_offers/my'
  all(:xpath, "(//a[text()='Edit'])")[1].click
end

And(/^I set title to 'Programmer Ruby'$/) do
  fill_in('job_offer[title]', :with => 'Programmer Ruby')
end

And(/^I click the button 'Save'$/) do
  click_button('Save')
end

Then(/^I should see the error 'You already have an offer with the same title'$/) do
  #page.should have_content('You already have an offer with the same title')
  pending
end
###