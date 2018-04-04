class User < ActiveRecord::Base
  has_many :recipes
  has_secure_password
  validates_presence_of :username, :email, :password

  def slug
    self.username.gsub(" ", "-").downcase
  end

  def self.find_by_slug(slug)
    name = slug.gsub("-", " ")
    User.all.detect{|user| user.username.downcase == name}
  end

end
