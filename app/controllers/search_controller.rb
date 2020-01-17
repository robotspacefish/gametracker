class SearchController < ApplicationController
  post '/search' do
    results = IgdbApi.search(params[:game][:title])
    games = IgdbApi.create_object_from_parsed_data(results)

    # Game.create(

    # )
  end

  get '/search/results' do

  end
end