class User < ActiveRecord::Base


  has_secure_password
  validates :first_name, :last_name, :email, :password, :password_confirmation, :presence => true
  validates :password, length: { minimum: 8 }, :presence => true
  validates_uniqueness_of :email, :case_sensitive => false
  before_validation :strip_whitespace_downcase

  def self.authenticate_with_credentials email, password
    user = User.find_by(email: email.downcase)
     if user && user.authenticate(password)
      user
    else
     nil
    end
  end

  def strip_whitespace_downcase
    self.email = self.email.strip.downcase unless self.email.nil?
  end

end
