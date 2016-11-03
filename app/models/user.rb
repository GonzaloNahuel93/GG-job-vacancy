class User
  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :crypted_password, String
  property :email, String
  has n, :job_offers

  validates_presence_of :name
  validates_presence_of :crypted_password
  validates_presence_of :email
  validates_format_of   :email,    :with => :email_address

  def password= (password)
    self.crypted_password = ::BCrypt::Password.create(password) unless password.nil?	
  end

  def self.authenticate(email, password)
    user = User.find_by_email(email)
    return nil if user.nil?
    user.has_password?(password)? user : nil
  end

  def has_password?(password)
    ::BCrypt::Password.new(crypted_password) == password
  end

  def has_offers_with_this_title? title
    job_offers.each do |actual|
      if (actual.get_title == title)
        return true
      end  
    end  
    return false
  end

  def has_offers_with_the_same_title_as_the_given? job_offer
    job_offers.each do |actual|
      if (actual.get_title == job_offer.get_title && actual.id != job_offer.id)
        return true
      end  
    end  
    return false
  end 

  def get_offers
    job_offers
  end

end
