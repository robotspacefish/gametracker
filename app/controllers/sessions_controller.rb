class SessionsController < ApplicationController
  get '/login' do
    if !logged_in?
      erb :'/sessions/login'
    else
      redirect "#{current_user_page}"
    end
  end

  post '/login' do
    login(params[:user])
    redirect "#{current_user_page}"
  end

  get '/logout' do
    logout!
    redirect '/'
  end

  get '/signup' do
    if !logged_in?
      erb :'/sessions/signup'
    else
      redirect "#{current_user_page}"
    end
  end
end