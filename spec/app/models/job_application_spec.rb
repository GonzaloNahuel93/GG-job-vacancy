require 'spec_helper'

describe JobApplication do

	describe 'model' do

		subject { @job_offer = JobApplication.new }

		it { should respond_to( :applicant_email ) }
		it { should respond_to( :job_offer) }

	end


	describe 'create_for' do

	  it 'should set applicant_email' do
	  	email = 'applicant@test.com'
	  	ja = JobApplication.create_for(email, JobOffer.new)
	  	ja.applicant_email.should eq email
	  end

	  it 'should set job_offer' do
	  	offer = JobOffer.new
	  	ja = JobApplication.create_for('applicant@test.com', offer)
	  	ja.job_offer.should eq offer
	  end

	end


	describe 'process' do

	  let(:job_application) { JobApplication.new }

	  it 'should deliver contact info notification' do
	  	ja = JobApplication.create_for('applicant@test.com', JobOffer.new)
	  	JobVacancy::App.should_receive(:deliver).with(:notification, :contact_info_email, ja)
	  	ja.process
	  end

	end

	describe 'valid_email?' do

      before do
        email = 'oneemail@test.com'
	  	@job_application = JobApplication.create_for(email, JobOffer.new)
      end

	  it 'Should return true when i enter the valid email -oneemail@gmail.com-' do
        result = @job_application.valid_email? 'oneemail@gmail.com'
	    expect(result).to eq true
	  end

	  it 'Should return true when i enter the valid email -this.is.a.email@untref.arg-' do
        result = @job_application.valid_email? 'this.is.a.email@untref.arg'
	    expect(result).to eq true
	  end

	  it 'Should return false when i enter the invalid email -Hello World!-' do
        result = @job_application.valid_email? 'Hello World!'
	    expect(result).to eq false
	  end

	  it 'Should return false when i enter the invalid email -a.email@@test.com-' do
        result = @job_application.valid_email? 'a.email@@test.com'
	    expect(result).to eq false
	  end

	  it 'Should return false when i enter the invalid email -e.email@test-' do
        result = @job_application.valid_email? 'e.email@test'
	    expect(result).to eq false
	  end

	end

end