class RecipesController < ApplicationController

  get '/recipes' do
    @recipes = Recipe.all
    erb :'recipes/index'
  end

  get '/recipes/new' do
    erb :'/recipes/new'
  end

  post '/recipes' do
    @recipe = current_user.recipes.build(name: params["name"], ingredients: params["ingredients"], procedure: params["procedure"])
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
    if @recipe.user_id == current_user.id
      erb :'recipes/edit'
    else
      redirect '/recipes'
    end
  end

  post '/recipes/:id' do
    @recipe = Recipe.find_by(id: params[:id])
    if @recipe.user_id == current_user.id
      @recipe.name = params[:name]
      @recipe.ingredients = params[:ingredients]
      @recipe.procedure = params[:procedure]
      @recipe.save
      redirect to "/recipes/#{@recipe.id}"
    else
      redirect to '/recipes'
    end
  end

  delete '/recipes/:id/delete' do
    @recipe = Recipe.find_by(id: params[:id])
    if @recipe.user_id == current_user.id
      @recipe.destroy
      redirect '/recipes'
    else
      redirect '/recipes'
    end
  end

end
