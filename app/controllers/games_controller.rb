class GamesController < ApplicationController
  get '/games' do
    @games = Game.all
    erb :'games/index'
  end

  get '/games/new' do
    erb :'/games/new'
  end

  get '/games/:slug' do
    @game = Game.find_by_slug(params[:slug])

    erb :'/games/show'
  end
end