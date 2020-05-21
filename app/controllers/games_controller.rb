class GamesController < ApplicationController
  use Rack::Flash

  get '/games' do
    redirect_if_not_logged_in

    pre_sorted_games = Game.find_all_owned_game_titles
    print pre_sorted_games
    @games = Game.sort_array_by_title(pre_sorted_games)
    print @games

    erb :'games/index'
  end

  get '/games/new' do
    # custom game form
    redirect_if_not_logged_in

    @platforms = Platform.all.order(:name)
    erb :'/games/new'

  end

  post '/games' do
    redirect_if_not_logged_in

    title = params[:game][:title]

    if title.blank?
      flash[:message] = "Title cannot be blank."
      redirect '/games/new'
    else
      # check db for game
      if @existing_game = Game.where("title ILIKE ?", title)[0]
        flash[:message] = "This game already exists."

        if !!current_user.games.find_by(id: @existing_game.id)
          flash[:message] = "You already have #{@existing_game.title} in your library."
        end
        erb :'games/add_existing_game'
      else

        game = Game.create_custom_game(params[:game])
        current_user.add_custom_game_to_library(game)

        platform = Platform.find(params[:game][:platform_id])

        flash[:message] = "#{params[:game][:title]} for #{platform.name} added."

        redirect to current_user_page
      end

    end
  end

  post '/games/add_existing_game' do
    redirect_if_not_logged_in

    game = Game.find_by(id: params[:game][:id])
    game_platform = game.game_platforms.where("platform_id = ?", params[:game][:platform_id])

    platform = Platform.find(params[:game][:platform_id])

    current_user.game_platforms << game_platform

    flash[:message] = "#{game.title} for #{platform.name} added."

    redirect to current_user_page
  end

  get '/games/:slug' do
    set_game

    if !@game
      flash[:message] = "That game doesn't exist in our database. Try using the search bar."

      redirect '/error'
    end

    erb :'/games/show'
  end

  get '/games/:slug/edit' do
    if logged_in?
      set_game
      if @game.custom
        erb :'/games/edit'
      else
        flash[:message] = "You cannot edit this title."
        redirect "/games/#{params[:slug]}"
      end

    else
      redirect "/"
    end
  end

  patch '/games/:slug/edit' do
    set_game

    @game.update(params[:game])
    if @game.save
      redirect "/games/#{params[:slug]}"
    else
      flash[:message] = "There was a problem editing this game. Please try again."
      redirect "/games/#{params[:slug]}/edit"
    end
  end

  private
  def set_game
    @game = Game.find_by_slug(params[:slug])
  end
end