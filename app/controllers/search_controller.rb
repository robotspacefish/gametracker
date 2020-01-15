class SearchController < ApplicationController
  post '/search' do
    @results = IgdbApi.search(params[:game][:title])
    binding.pry
  end

  get '/search/results' do

  end
end