class GenresController < ApplicationController

  #index
  get '/genres' do
    @genre = Genre.all
    erb :'genre/index'
  end
end
