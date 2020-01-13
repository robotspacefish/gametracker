class SessionsController < ApplicationController
  get '/login' do
    if !logged_in?
      erb :'/sessions/login'
    else
      redirect "/users/#{current_user.slug}"
    end
  end

  post '/login' do
    login(params[:user])
    redirect "/users/#{current_user.slug}"
  end

  get '/logout' do
    logout!
    redirect '/'
  end

  get '/signup' do
    erb :'/sessions/signup'
  end
end