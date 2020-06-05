class RecipesController < ApplicationController

  #index
  get '/recipes' do
    @recipes = Recipe.all
    @genres = Genre.all
    erb :'recipes/index'
  end

  #new
  get '/recipes/new' do
    if !logged_in?
      redirect "/login"
    else
      erb :'recipes/new'
    end
  end

  #create
   post '/recipes' do
    if !params["recipe"]["name"].empty? && !params["recipe"]["genre_id"].empty? && !params["recipe"]["genre_id"].empty? && !params["recipe"]["main_ingrediant"].empty? && !params["recipe"]["instructions"].empty?

    recipe = Recipe.create(params[:recipe])
    recipe.user= current_user
    recipe.save

    redirect to "/recipes/#{recipe.id}"

    else
      flash[:required_fields]= "All fields must be completed. Only notes are optional."
      erb :'recipes/new'
    end
   end

   #edit
 get '/recipes/:id/edit' do
   id = params[:id]
   @recipe = Recipe.find_by(id: id)
   current_user
   if !logged_in? || @recipe.user_id != @current_user.id
     erb :'recipes/error'
   else
     erb :'recipes/edit'
   end
 end

  #Update
  put '/recipes/:id' do
    recipe = Recipe.find_by(id: params[:id])
    recipe.update(params[:recipe])
    redirect to "/recipes/#{recipe.id}"
  end

  #Destroy
  delete '/recipes/:id' do
    id = params[:id]
    @recipe = Recipe.find_by(id: id)
    current_user
    if !logged_in? || @recipe.user_id != @current_user.id
      erb :'recipes/error'
    else
      @recipe.delete
      redirect to "/recipes"
  end
end

  #show
  get '/recipes/:id' do
    id = params[:id]
      @recipe = Recipe.find_by(id: id)
    erb :'recipes/show'
  end
end
