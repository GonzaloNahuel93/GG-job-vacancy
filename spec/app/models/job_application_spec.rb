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
	  	ja = JobApplication.create_for(email, 'John', 'Doe', 'Hi Im John', 'www.johncurriculum.net', JobOffer.new)
	  	ja.applicant_email.should eq email
	  end

	  it 'should set job_offer' do
	  	offer = JobOffer.new
	  	ja = JobApplication.create_for('applicant@test.com', 'John', 'Doe', 'Hi Im John', 'www.johncurriculum.net', offer)
	  	ja.job_offer.should eq offer
	  end

	  it 'should set first name' do
	  	applic_name = 'John'
	  	ja = JobApplication.create_for('applicant@test.com', applic_name, 'Doe', 'Hi Im John', 'www.johncurriculum.net', JobOffer.new)
	  	ja.first_name.should eq applic_name
	  end

	  it 'should set last name' do
	  	applic_last_name = 'Doe'
	  	ja = JobApplication.create_for('applicant@test.com', 'John', applic_last_name, 'Hi Im John', 'www.johncurriculum.net', JobOffer.new)
	  	ja.last_name.should eq applic_last_name
	  end

	  it 'should set presentation' do
	  	presentation = 'Hi Im John'
	  	ja = JobApplication.create_for('applicant@test.com', 'John', 'Doe', presentation, 'www.johncurriculum.net', JobOffer.new)
	  	ja.presentation.should eq presentation
	  end

	  it 'should set curriculum' do
	  	curriculum = 'www.johncurriculum.net'
	  	ja = JobApplication.create_for('applicant@test.com', 'John', 'Doe', 'Hi Im John', curriculum, JobOffer.new)
	  	ja.curriculum.should eq curriculum
	  end

	end


	describe 'process_to_applicant' do

	  let(:job_application) { JobApplication.new }

	  it 'should deliver contact info notification' do
	  	ja = JobApplication.create_for('applicant@test.com', 'John', 'Doe', 'Hi Im John', 'www.johncurriculum.net', JobOffer.new)
	  	JobVacancy::App.should_receive(:deliver).with(:notification, :application_info_to_applicant, ja)
	  	ja.process_to_applicant
	  end

	end

	describe 'valid_email?' do

      before do
        email = 'oneemail@test.com'
	  	@job_application = JobApplication.create_for(email, 'John', 'Doe', 'Hi Im John', 'www.johncurriculum.net', JobOffer.new)
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