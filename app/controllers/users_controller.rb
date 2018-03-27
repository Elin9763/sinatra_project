class UsersController < ApplicationController

  get '/login' do
    if logged_in?
      redirect '/recipes'
    else
      erb :'users/login'
    end
  end

  get '/signup' do
    erb :'users/signup'
  end


end
