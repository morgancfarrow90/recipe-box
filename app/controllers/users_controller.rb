class UsersController < ApplicationController

  get '/signup' do
    erb :'users/new'
  end

  post '/users' do
    if params[:user_email] == "" || params[:password] == ""
    erb :'users/error'
    else
    @user = User.new
    @user.user_email = params[:user_email]
    @user.password = params[:password]
    @user.save
      redirect '/login'
    end
  end
end
