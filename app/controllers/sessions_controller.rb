class SessionsController < ApplicationController

  get '/signup' do
    erb :'sessions/new'
  end

  post '/signup' do
    if params[:user][:user_email] == "" || params[:user][:password] == ""
    erb :'sessions/signuperror'
    else
    user = User.new(params[:user])
    user.save
    redirect '/login'
    end
  end

  get '/login' do
    erb :'sessions/login'
  end

  post '/login' do
    user = User.find_by(user_email: params[:user_email])
    if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    redirect '/recipes'
    else
    erb :'sessions/loginerror'
    end
  end

  get '/logout' do
    logout!
    erb :'sessions/logout'
  end

end
