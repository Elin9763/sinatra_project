class RecipesController < ApplicationController

  get '/recipes' do
    erb :'recipes/index'
  end

  get '/recipes/new' do
    erb :'/recipes/new'
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
    @recipe = Recipe.find_by(id: params[:id])
    erb :'/recipes/show'
  end

  get '/recipes/:id/edit' do
    @recipe = Recipe.find_by(id: params[:id])
    erb :'recipes/edit'
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
    if logged_in?
      @recipe.destroy
      redirect '/recipes'
    else
      redirect "/recipes/#{@recipe.id}"
    end
  end

end
