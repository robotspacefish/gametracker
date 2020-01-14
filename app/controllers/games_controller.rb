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
      title = params[:game][:title]

      if title.blank?
        # TODO error "Title cannot be blank"
        redirect '/games/new'
      else
        # check db for game
        @existing_game = Game.where("title LIKE ?", title)[0]

        if @existing_game
          @user_has_game = !!current_user.games.find_by(id: @existing_game.id)
          erb :'games/add_existing_game'
        else
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
  end

  post '/games/existing_game' do
    if !logged_in?
      redirect '/login'
    else
      # Add existing game to User's library
      current_user.games << Game.find_by(id: params[:game][:id])
      redirect to current_user_page
    end
  end

  get '/games/:slug' do
    @game = Game.find_by_slug(params[:slug])

    erb :'/games/show'
  end
end