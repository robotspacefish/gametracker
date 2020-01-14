class GamesController < ApplicationController
  get '/games' do
    @games = Game.all
    erb :'games/index'
  end

  get '/games/new' do
    if !logged_in?
      redirect '/login'
    else
      erb :'/games/new'
    end
  end

  post '/games/' do
    # TODOs
    # check for current user logged in
    # check db for game
    # if it doesn't exist, create it & add to all games
    # add to current user's library
    # reroute to
  end

  get '/games/:slug' do
    @game = Game.find_by_slug(params[:slug])

    erb :'/games/show'
  end
end