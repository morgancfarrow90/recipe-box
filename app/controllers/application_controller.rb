require 'sinatra/base'

class ApplicationController < Sinatra::Base
  enable :sessions
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    set :session_secret, "recipes"
    end

  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end

    def logout!
      session.clear
    end
  end

#Site Welcome Page
  get '/' do
    @recipes = Recipe.all
    @genres = Genre.all
    erb :welcome
    end

end
