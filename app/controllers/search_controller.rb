class SearchController < ApplicationController
  post '/search/results' do
    if !logged_in?
      redirect '/login'
    else
      parsed_results = IgdbApi.search(params[:game][:title])
      game_objects = IgdbApi.create_objects_from_parsed_data(parsed_results)

      game_objects.each do |game|
        # I only want to add games with platforms
        if game[:platforms] &&
          !game[:platforms].empty? &&
          !Game.exists_in_db?(game[:igdb_id])
          Game.add_game_to_db(game)
        end
      end

      @search_results = Game.find_search_results(params[:game][:title])

      erb :'/search/results'
    end
  end
end