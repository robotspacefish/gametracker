class SearchController < ApplicationController
  post '/search/results' do
    results = IgdbApi.search(params[:game][:title])
      games_objects = IgdbApi.create_objects_from_parsed_data(results)

    # Game.create(

    # )
  end

  get '/search/results' do

  end
end