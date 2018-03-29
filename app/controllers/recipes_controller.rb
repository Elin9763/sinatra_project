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
end
