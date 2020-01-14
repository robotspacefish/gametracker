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
          #TODO verify content before adding
          # if it doesn't exist, create it & add to all games
          # and add to current user's library
          @game = current_user.games.build(params[:game])
          if current_user.save
            redirect to current_user_page
          else
            # redirect to '/games/new'
            <<-ERROR
              There was a problem adding this game.
              <a href=/games/new>Back to Add Custom Game</a>
            ERROR
          end
      end
    end
  end


  get '/games/:slug' do
    @game = Game.find_by_slug(params[:slug])

    erb :'/games/show'
  end
end