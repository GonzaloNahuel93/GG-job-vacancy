##
# Mailer methods can be defined using the simple format:
#
# email :registration_email do |name, user|
#   from 'admin@site.com'
#   to   user.email
#   subject 'Welcome to the site!'
#   locals  :name => name
#   content_type 'text/html'       # optional, defaults to plain/text
#   via     :sendmail              # optional, to smtp if defined, otherwise sendmail
#   render  'registration_email'
# end
#
# You can set the default delivery settings from your app through:
#
#   set :delivery_method, :smtp => {
#     :address         => 'smtp.yourserver.com',
#     :port            => '25',
#     :user_name       => 'user',
#     :password        => 'pass',
#     :authentication  => :plain, # :plain, :login, :cram_md5, no auth by default
#     :domain          => "localhost.localdomain" # the HELO domain provided by the client to the server
#   }
#
# or sendmail (default):
#
#   set :delivery_method, :sendmail
#
# or for tests:
#
#   set :delivery_method, :test
#
# or storing emails locally:
#
#   set :delivery_method, :file => {
#     :location => "#{Padrino.root}/tmp/emails",
#   }
#
# and then all delivered mail will use these settings unless otherwise specified.
#

JobVacancy::App.mailer :notification do

  email :application_info_to_applicant do | job_application |
    from 'informationjobvacancy2016@gmail.com'
    to job_application.applicant_email
    subject 'Job Application: Información al Aplicante'
    locals :job_offer => job_application.job_offer,
           :email => job_application.job_offer.owner.email
    content_type :plain
    via :sendmail
    render 'notification/contact_info_email'
  end

  email :application_info_to_owner do | job_application |
    from 'informationjobvacancy2016@gmail.com'
    to job_application.job_offer.owner.email
    subject 'Job Application: Información al Offerer'
    locals :job_offer => job_application.job_offer,
           :first_name => job_application.first_name,
           :last_name => job_application.last_name,
           :presentation => job_application.presentation,
           :curriculum => job_application.curriculum
    content_type :plain
    via :sendmail 
    render 'notification/offerer_info_email'
  end

end
