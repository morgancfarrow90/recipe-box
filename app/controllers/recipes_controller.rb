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

    if !params["recipe"]["name"].empty? && params["recipe"]["genre_id"] != nil && !params["recipe"]["main_ingrediant"].empty? && !params["recipe"]["ingredients"].empty? && !params["recipe"]["instructions"].empty?

    recipe = Recipe.create(params[:recipe])
    recipe.user= current_user
    recipe.save

    redirect to "/recipes/#{recipe.id}"

    else
      erb :'recipes/create_error'
    end
   end

   #edit
 get '/recipes/:id/edit' do
   id = params[:id]
   @recipe = Recipe.find_by(id: id)
   current_user
   if !logged_in? || @recipe.user_id != @current_user.id
     erb :'recipes/accesserror'
   else
     erb :'recipes/edit'
   end
 end

  #update
  put '/recipes/:id' do
    recipe = Recipe.find_by(id: params[:id])
    if !logged_in? || recipe.user_id != current_user.id
      erb :'recipes/accesserror'
    else
      recipe.update(params[:recipe])
      redirect to "/recipes/#{recipe.id}"
    end
  end

  #destroy
  delete '/recipes/:id' do
    id = params[:id]
    @recipe = Recipe.find_by(id: id)
    current_user
    if !logged_in? || @recipe.user_id != @current_user.id
      erb :'recipes/accesserror'
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

  #custom
  #search by main ingredient
  get '/search' do
    erb :'recipes/search'
  end

  #search results
  get '/searchresult' do
    @main = params[:main]

    @recipes= Recipe.where("ingredients Like ?", "%#{params[:main]}%")
    erb :'recipes/searchresult'
  end

end
