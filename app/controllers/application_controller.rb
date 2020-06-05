require 'sinatra/base'
require 'rack-flash'


class ApplicationController < Sinatra::Base
  enable :sessions
  use Rack::Flash
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
      @current_user ||= User.find_by(:user_email => session[:user_email]) if session[:user_email]
    end

    def login(user_email, password)
      #is the user who they claim to be
      user = User.find_by(:user_email => user_email)
      if user && user.authenticate(params[:password])
      session[:user_email] = user.user_email
      else
          erb :'sessions/error'
      end
    end

    def logout!
      session.clear
    end
  end

  get '/' do
    @recipes = Recipe.all
    @genres = Genre.all
    erb :welcome
    end

end
