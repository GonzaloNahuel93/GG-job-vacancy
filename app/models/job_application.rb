class JobApplication

	attr_accessor :applicant_email
	attr_accessor :job_offer

	def self.create_for(email, offer)
	  app = JobApplication.new
	  app.applicant_email = email
    app.job_offer = offer
	  app
	end

	def process_to_applicant
      JobVacancy::App.deliver(:notification, :contact_info_email, self)
    end

    def process_to_offerer
      JobVacancy::App.deliver(:notification, :offerer_info_email, self)
    end

    def valid_email?(email)
      (email =~ /^[A-Za-z0-9](([_\.\-]?[a-zA-Z0-9]+)*)@([A-Za-z0-9]+)(([\.\-]?[a-zA-Z0-9]+)*)\.([A-Za-z])+$/)==0
    end

end
