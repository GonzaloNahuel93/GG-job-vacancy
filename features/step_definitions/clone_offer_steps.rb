And(/^There is at least one existing offer posted by me$/) do
  JobOffer.all.destroy #Necesario para probar el Clone.
  visit '/job_offers/new/'
  @title = 'Programador Ruby-Padrino'
  @location = 'Ciudad de Buenos Aires'
  @description = 'Buscamos alguien capaz de trabajar en el proyecto Job Vacancy'
  fill_in('job_offer[title]', :with => @title)
  fill_in('job_offer[location]', :with => @location)
  fill_in('job_offer[description]', :with => @description)
  click_button('Create')
  page.should have_content('Programador Ruby-Padrino')
end

Given(/^I am watching the Ruby-Padrino offer$/) do
  visit '/job_offers/my'
  page.should have_content(@title)
  page.should have_content(@location)
  page.should have_content(@description)
end

When(/^I press the clone button for my offer$/) do
  click_link('Clone')
end

Then(/^I should be able to edit a copy of it$/) do
  expect(URI.parse(current_url)).to have_content '/job_offers/clone'
  expect(page.find_field('Title').value).to eq 'Copy of ' + @title 
  expect(page.find_field('Location').value).to eq @location 
  expect(page.find_field('Description').value).to eq @description 
end

Given(/^I have previously created another offer named "(.*?)"$/) do |offer_title|
  @another_offers_title = offer_title
  visit '/job_offers/new/'
  fill_in('job_offer[title]', :with => @another_offers_title)
  fill_in('job_offer[location]', :with => 'Canada')
  fill_in('job_offer[description]', :with => 'Nada que decir')
  click_button('Create')
end

And(/^I am editing my cloned offer$/) do
  visit '/job_offers/my'
  page.should have_content @another_offers_title
  all(:xpath, "(//a[text()='Clone'])")[1].click
  expect(page.find_field('Title').value).to have_content @another_offers_title
end

When(/^I try to post the cloned offer naming it "(.*?)"$/) do |offer_title|
  fill_in('job_offer[title]', :with => offer_title)
  click_button('Create')
end

Then(/^It should show me an error message$/) do 
  pending
  #page.should have_content('You already have an offer with the same title')
end