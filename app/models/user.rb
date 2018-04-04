class User < ActiveRecord::Base
  has_many :recipes
  has_secure_password
  validates_presence_of :username, :email, :password
end
