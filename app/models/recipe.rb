class Recipe < ActiveRecord::Base
  belongs_to :users
  validates_presence_of :name, :ingredients, :procedure
end
