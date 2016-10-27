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
  expect(page.find_field('Title').value).to eq 'Nueva oferta' 
  expect(page.find_field('Location').value).to eq @location 
  expect(page.find_field('Description').value).to eq @description 
end

Given(/^I am editing my cloned offer$/) do
  pending
end

When(/^I try to post it with the same name as the original$/) do
  pending
end

Then(/^It should show me an error message$/) do 
  pending
end

Given(/^I have previously created another offer named "Programador Python"$/) do |offer_title|
  pending
end

When(/^I try to post the cloned offer naming it "Programador Python$/) do |offer_title|
  pending
end
