require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "sinatra_project"
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      user = User.find_by_id(session[:user_id])
    end
  end


  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    if @user
      erb :'/users/show'
    else
      redirect '/'
    end
  end

end
