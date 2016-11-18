class JobApplication

	attr_accessor :applicant_email
  attr_accessor :first_name
  attr_accessor :last_name
	attr_accessor :presentation
  attr_accessor :curriculum
  attr_accessor :job_offer

	def self.create_for(email, first_name, last_name, presentation, curriculum, offer)
	  app = JobApplication.new
	  app.applicant_email = email
    app.first_name = first_name
    app.last_name = last_name
    app.presentation = presentation
    app.curriculum = curriculum
    app.job_offer = offer
	  app
	end

	def process_to_applicant
    JobVacancy::App.deliver(:notification, :application_info_to_applicant, self)
  end

  def process_to_offerer
    JobVacancy::App.deliver(:notification, :application_info_to_owner, self)
  end

  def valid_email?(email)
    (email =~ /^[A-Za-z0-9](([_\.\-]?[a-zA-Z0-9]+)*)@([A-Za-z0-9]+)(([\.\-]?[a-zA-Z0-9]+)*)\.([A-Za-z])+$/)==0
  end

end
