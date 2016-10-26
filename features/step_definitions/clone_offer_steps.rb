Given(/^There is at least one existing offer posted by me$/) do
  #visit '/job_offers/new/'
  #fill_in('job_offer[title]', :with => 'Programador Ruby-Padrino')
  #fill_in('job_offer[location]', :with => 'Ciudad de Buenos Aires')
  #fill_in('job_offer[description]', :with => 'Buscamos alguien capaz de trabajar en el proyecto Job Vacancy')
  #click_button('Create')
  #page.should have_content('Programador Ruby-Padrino')
  pending
end

Given(/^I am watching the Ruby-Padrino offer$/) do
  #visit '/job_offers'
  #page.should have_content('Programador Ruby-Padrino')
  #page.should have_content('Ciudad de Buenos Aires')
  #page.should have_content('Buscamos a alguien capaz de trabajar en el proyecto Job Vacancy')
  pending
end

When(/^I press the clone button for my offer$/) do
  #click_button('Clone')
  pending
  #¿Como le digo que es exactamente el clone de la oferta que quiero y no de otra?
end

Then(/^I should be able to edit a copy of it$/) do 
  #visit '/job_offers/new'
  #page.should have_content('Programador Ruby-Padrino')
  #page.should have_content('Ciudad de Buenos Aires')
  #page.should have_content('Buscamos a alguien capaz de trabajar en el proyecto Job Vacancy')
  pending
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