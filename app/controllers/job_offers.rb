JobVacancy::App.controllers :job_offers do
  
  get :my do
    @offers = JobOffer.find_by_owner(current_user)
    render 'job_offers/my_offers'
  end    

  get :index do
    @offers = JobOffer.all_active
    render 'job_offers/list'
  end  

  get :new do
    @job_offer = JobOffer.new
    render 'job_offers/new'
  end

  get :latest do
    @offers = JobOffer.all_active
    render 'job_offers/list'
  end

  get :edit, :with => :offer_id  do
    @job_offer = JobOffer.get(params[:offer_id])
    # ToDo: validate the current user is the owner of the offer
    render 'job_offers/edit'
  end

  get :clone, :with => :offer_id  do
    @job_offer = JobOffer.get(params[:offer_id])
    title = @job_offer[:title]
    @job_offer[:title] = 'Copy of ' + title
    render 'job_offers/new'
    # ToDo: validate the current user is the owner of the offer
  end

  get :apply, :with =>:offer_id  do
    @job_offer = JobOffer.get(params[:offer_id])
    @job_application = JobApplication.new
    # ToDo: validate the current user is the owner of the offer
    render 'job_offers/apply'
  end

  post :search do
    @offers = JobOffer.all(:title.like => "%#{params[:q]}%")
    render 'job_offers/list'
  end

  post :apply, :with => :offer_id do

    @job_offer = JobOffer.get(params[:offer_id])    
    applicant_email = params[:job_application][:applicant_email]
    first_name = params[:job_application][:first_name]
    last_name = params[:job_application][:last_name]
    presentation = params[:job_application][:presentation]
    curriculum = params[:job_application][:curriculum]

    @job_application = JobApplication.create_for(applicant_email, first_name, last_name, presentation, curriculum, @job_offer)

    if @job_application.valid_email?(applicant_email)
      @job_application.process_to_applicant
      @job_application.process_to_offerer
      flash[:success] = 'Contact information sent.'
      redirect '/job_offers'
    else
      flash.now[:error] = 'Please enter a valid email address'
      render 'job_offers/apply'
    end
  end

  post :create do
    @job_offer = JobOffer.new(params[:job_offer])
    @job_offer.owner = current_user
    if @job_offer.owner.has_offers_with_the_same_title_as_the_given? @job_offer
      flash.now[:error] = 'You already have an offer with the same title'
      render 'job_offers/new'
    else
      if @job_offer.save
        if params['create_and_twit']
          TwitterClient.publish(@job_offer)
        end 
        flash[:success] = 'Offer created'
        redirect '/job_offers/my'
      else
        flash.now[:error] = 'Title is mandatory'
        render 'job_offers/new'
      end  
    end
  end

  post :update, :with => :offer_id do

    @job_offer = JobOffer.get(params[:offer_id])
    form_offer = params[:job_offer]

    if ( (@job_offer.owner.has_offers_with_this_title? form_offer[:title]) && (params[:offer_id]!= @job_offer.owner.which_offer_has_this_title?(form_offer[:title]).id.to_s))
      flash.now[:error] = 'You already have an offer with the same title'
      render 'job_offers/edit'
    else
      @job_offer.update(params[:job_offer])
      if @job_offer.save
        flash[:success] = 'Offer updated'
        redirect '/job_offers/my'
      else
        flash.now[:error] = 'Title is mandatory'
        render 'job_offers/edit'
      end  
    end

  end

  put :activate, :with => :offer_id do
    @job_offer = JobOffer.get(params[:offer_id])
    @job_offer.activate
    if @job_offer.save
      flash[:success] = 'Offer activated'
      redirect '/job_offers/my'
    else
      flash.now[:error] = 'Operation failed'
      redirect '/job_offers/my'
    end  
  end

  get :delete, :with => :offer_id  do
    @job_offer = JobOffer.get(params[:offer_id])
    render '/job_offers/confirm_deletion'
  end

  delete :destroy do
    @job_offer = JobOffer.get(params[:offer_id])
    if @job_offer.destroy
      flash[:success] = 'Offer deleted'
    else
      flash.now[:error] = 'Title is mandatory'
    end
    redirect 'job_offers/my'
  end



end
