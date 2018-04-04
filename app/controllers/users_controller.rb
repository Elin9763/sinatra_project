class UsersController < ApplicationController

  get '/' do
    erb :index
  end

  get '/login' do
    if !logged_in?
      erb :'users/login'
    else
      redirect '/recipes'
    end
  end

  post '/users/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to "/recipes"
    else
      redirect to '/login'
    end
  end

  get '/signup' do
    erb :'users/signup'
  end

  post '/users/signup' do
    @user = User.new(username: params[:username], email: params[:email], password: params[:password])
    if @user.save
      session[:user_id] = @user.id
      redirect "/recipes"
    else
      redirect 'users/signup'
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
