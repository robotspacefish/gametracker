class SearchController < ApplicationController
  post '/search/results' do
    if !logged_in?
      redirect '/login'
    else
      results = IgdbApi.search(params[:game][:title])
      @games_objects = IgdbApi.create_objects_from_parsed_data(results)

      erb :'/search/results'
    end

  end

  get '/search/results' do
    erb :'/search/results'
  end
end