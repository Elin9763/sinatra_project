class UsersController < ApplicationController

  get '/login' do
    if logged_in?
      redirect '/recipes'
    else
      erb :'users/login'
    end
  end

  post '/users/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to '/recipes'
    else
      session[:error] = "Incorrect"
      redirect to '/login'
    end
  end

  get '/signup' do
    erb :'users/signup'
  end

  post '/users/signup' do
    @user = User.new(username: params[:username], password: params[:password], email: params[:email])
    if @user.save
      redirect '/recipes'
    else
      redirect '/signup'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end

end
