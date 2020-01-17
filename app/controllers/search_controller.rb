class SearchController < ApplicationController
  post '/search/results' do
    if !logged_in?
      redirect '/login'
    else
      parsed_results = IgdbApi.search(params[:game][:title])
      game_objects = IgdbApi.create_objects_from_parsed_data(parsed_results)

      @search_results = game_objects.collect do |game|
        # todo check custom games with no igdb_id first?
        Game.find_or_add_game_to_db(game)
      end.compact!
      # binding.pry
      erb :'/search/results'
    end

  end

  get '/search/results' do
    erb :'/search/results'
  end
end