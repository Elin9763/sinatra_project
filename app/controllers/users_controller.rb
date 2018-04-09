class UsersController < ApplicationController

  get '/index' do
    erb :index
  end

  get '/login' do
    if !session[:user_id]
      erb :"users/login"
    else
      redirect to '/recipes'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to "/recipes"
    else
      flash[:warning] = "Please double check your username and password!"
      redirect to '/login'
    end
  end

  get '/signup' do
    erb :'users/signup'
  end

  post '/signup' do
    @user = User.new(username: params[:username], email: params[:email], password: params[:password])
    if @user.save
      session[:user_id] = @user.id
      redirect "/recipes"
    else
      flash[:warning] = "Did you miss something?"
      redirect '/signup'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect '/'
    else
      redirect 'users/login'
    end
  end

end
