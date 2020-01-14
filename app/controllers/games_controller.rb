class GamesController < ApplicationController
  get '/games' do
    if !logged_in?
      redirect '/login'
    else
      @games = Game.all
      erb :'games/index'
    end
  end

  get '/games/new' do
    if !logged_in?
      redirect '/login'
    else
      erb :'/games/new'
    end
  end

  post '/games' do
    if !logged_in?
      redirect '/login'
    else
      # check db for game
      @existing_game = Game.find_by(title: params[:game][:title])
      if @existing_game
        @user_has_game = !!current_user.games.find_by(id: @existing_game.id)
        erb :'games/add_existing_game'
      else

      end
    end
  end


  get '/games/:slug' do
    @game = Game.find_by_slug(params[:slug])

    erb :'/games/show'
  end
end