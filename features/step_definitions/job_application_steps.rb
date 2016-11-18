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
  #click_link('Apply') #Esto va a agarrar siempre la primer oferta, porque en caso de haber varias, el link 'Apply' genera ambiguedad
  #fill_in('job_application[applicant_email]', :with => 'applicant@test.com')
  #click_button('Apply')
end

Then(/^I should receive a mail with offerer info$/) do
  #mail_store = "#{Padrino.root}/tmp/emails"
  #file = File.open("#{mail_store}/applicant@test.com", "r")
  #content = file.read
  #content.include?(@job_offer.title).should be true
  #content.include?(@job_offer.location).should be true
  #content.include?(@job_offer.description).should be true
  #content.include?(@job_offer.owner.email).should be true
  #content.include?(@job_offer.owner.name).should be true
  pending
end

Given(/^I access the offers list page$/) do
  visit '/job_offers'
end

When(/^I click apply$/) do
  click_link('Apply')
end

And(/^I enter an invalid email address for apply$/) do
  fill_in('job_application[applicant_email]', :with => 'Hello World!')
  click_button('Apply')
end

Then(/^I should see the error 'Please enter a valid email address'$/) do
  page.should have_content('Please enter a valid email address')
end

Then(/^Then I should be able to see 'First Name', 'Last Name', 'Presentation' and 'Curriculum' fields$/) do
  page.should have_content('First Name')
  page.should have_content('Last Name')
  page.should have_content('Presentation')
  page.should have_content('Curriculum')
end