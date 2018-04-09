require './config/environment'
require 'sinatra/flash'

class ApplicationController < Sinatra::Base

  configure do
    register Sinatra::Flash
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "sinatra_project"
  end

  get '/' do
    erb :index
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      user = User.find_by_id(session[:user_id])
    end
  end



end
