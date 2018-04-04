class RecipesController < ApplicationController

  get '/recipes' do
    if logged_in?
      @user = current_user
      erb :'recipes/index'
    else
      redirect '/login'
    end
  end

  get '/recipes/new' do
    if logged_in?
      erb :'/recipes/new'
    else
      redirect '/login'
    end
  end

  post '/recipes' do
    @recipe = Recipe.new(name: params["name"], ingredients: params["ingredients"], procedure: params["procedure"])
  	if @recipe.save
      redirect "/recipes/#{@recipe.id}"
    else
      redirect "/recipes/new"
    end
  end

  get '/recipes/:id' do
    if logged_in?
  		@recipe = Recipe.find_by(id: params[:id])
  		@user = current_user
  		erb :'recipes/show'
  	else
  		redirect '/login'
  	end
  end

  get '/recipes/:id/edit' do
    if logged_in?
  		@recipe = Recipe.find_by(id: params[:id])
  		erb :'recipes/edit'
  	else
  		redirect '/login'
  	end
  end

  patch '/recipes/:id' do
    @recipe = Recipe.find_by(id: params[:id])
    @recipe.name = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.procedure = params[:procedure]
    @recipe.save
    redirect to "/recipes/#{@recipe.id}"
  end

  delete '/recipes/:id/delete' do
    @recipe = Recipe.find_by(id: params[:id])
    logged_in? && @recipe.users == current_user
    @recipe.destroy
    redirect '/recipes'
  end

end
