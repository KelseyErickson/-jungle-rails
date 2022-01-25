class User < ActiveRecord::Base

  has_secure_password
  validates :first_name, :last_name, :email, :password, :password_confirmation, :presence => true
  validates :password, length: { minimum: 8 }, :presence => true
  validates_uniqueness_of :email, :case_sensitive => false
  
end
