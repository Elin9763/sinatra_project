require './config/environment'
require './app/helpers/helper_methods'

class ApplicationController < Sinatra::Base
  include HelperMethods

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "sinatra_project"
  end



end
