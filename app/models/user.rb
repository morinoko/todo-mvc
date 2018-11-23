class User < ApplicationRecord
  has_secure_password
  
  validates :email, presence: true
  validates :email, uniqueness: true
  
  def self.find_or_create_by_omniauth(auth_hash)
    omniauth_email = auth_hash["info"]["email"]
    
    self.where(email: omniauth_email).first_or_create do |user|
      user.password = SecureRandom.hex
      # Could also store the provider and their userID on the provider
    end
  end
end
