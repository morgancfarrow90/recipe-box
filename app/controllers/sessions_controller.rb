class SessionsController < ApplicationController

  get '/login' do
    erb :'sessions/login'
  end

  post '/sessions' do
    user = User.find_by(user_email: params[:user_email])
    if user == nil
    #if params[:user_email] == "" || params[:password] == ""
      erb :'sessions/error'
    else
    login(params[:user_email], params[:password])
    redirect '/recipes'
  end
end

  get '/logout' do
    logout!
    erb :'sessions/logout'
  end

end
