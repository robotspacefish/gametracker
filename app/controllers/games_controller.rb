class GamesController < ApplicationController
  get '/games' do
    if !logged_in?
      redirect '/login'
    else
      pre_sorted_games = Game.find_all_owned_game_titles

      @games = Game.sort_array_by_title(pre_sorted_games)

      erb :'games/index'
    end
  end

  get '/games/new' do
    if !logged_in?
      redirect '/login'
    else
      @platforms = Platform.all.order(:name)
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
        if @existing_game = Game.where("title LIKE ?", title)[0]
          @user_has_game = !!current_user.games.find_by(id: @existing_game.id)
          erb :'games/add_existing_game'
        else
          game = Game.create_custom_game(params[:game])
          current_user.add_custom_game_to_library(game)
          redirect to current_user_page
        end

      end
    end
  end

  post '/games/add_existing_game' do
    if !logged_in?
      redirect '/login'
    else
      # Add existing game to User's library
# binding.pry
      game = Game.find_by(id: params[:game][:id])
      game_platform = game.game_platforms.where("platform_id = ?", params[:game][:platform_id])

      current_user.game_platforms << game_platform
      redirect to current_user_page
    end
  end

  get '/games/:slug' do
    @game = Game.find_by_slug(params[:slug])

    erb :'/games/show'
  end

  get '/games/:slug/edit' do
    if logged_in?
      @game = Game.find_by_slug(params[:slug])

      erb :'/games/edit'
    end
  end

  patch '/games/:slug/edit' do
    @game = Game.find_by_slug(params[:slug])
    @game.update(params[:game])
    if @game.save
      redirect "/games/#{params[:slug]}"
    else
      redirect "/games/#{params[:slug]}/edit"
    end
  end
end