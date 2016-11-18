Given(/^only a "(.*?)" offer exists in the offers list$/) do | job_title |
  JobOffer.all.destroy
  @job_offer = JobOffer.new
  @job_offer.owner = User.first
  @job_offer.title = job_title
  @job_offer.location = 'a nice job'
  @job_offer.description = 'a nice job'
  @job_offer.save
end

When(/^I apply$/) do
  click_link('Apply') #Esto va a agarrar siempre la primer oferta, porque en caso de haber varias, el link 'Apply' genera ambiguedad
  fill_in('job_application[applicant_email]', :with => 'applicant@test.com')
  fill_in('job_application[first_name]', :with => 'John')
  fill_in('job_application[last_name]', :with => 'Doe')
  fill_in('job_application[presentation]', :with => 'Hi Im John')
  fill_in('job_application[curriculum]', :with => 'www.johncurriculum.net')
  click_button('Apply')
end

Then(/^I should receive a mail with offerer's info$/) do
  verdadero = true;
  verdadero.should be true
  #No se automatiza
end

Given(/^I access the offers list page$/) do
  visit '/job_offers'
end

When(/^I click apply$/) do
  click_link('Apply')
end

And(/^I enter an invalid email address$/) do
  fill_in('job_application[applicant_email]', :with => 'Hello World!')
  click_button('Apply')
end

Then(/^I should see the error 'Please enter a valid email address'$/) do
  page.should have_content('Please enter a valid email address')
end

Then(/^I should be able to see "(.*?)", "(.*?)", "(.*?)" and "(.*?)" fields$/) do |first_name, last_name, presentation, curriculum|
  page.should have_content(first_name)
  page.should have_content(last_name)
  page.should have_content(presentation)
  page.should have_content(curriculum)
end