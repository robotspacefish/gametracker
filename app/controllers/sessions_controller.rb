require 'rack-flash'

class SessionsController < ApplicationController
  use Rack::Flash

  get '/login' do
    if !logged_in?
      erb :'/sessions/login'
    else
      redirect current_user_page
    end
  end

  post '/login' do
    login(params[:user])
   if !logged_in?
      "error loging in"
   else
      redirect current_user_page
   end
  end

  get '/logout' do
    logout!
    redirect '/'
  end

  get '/signup' do
    if !logged_in?
      erb :'/sessions/signup'
    else
      redirect current_user_page
    end
  end

  post '/signup' do
    username = nil
    if User.valid_username?(params[:user][:username]) &&
      !User.username_taken?(params[:user][:username]) &&
      User.valid_password?(params[:user][:password])
      user = User.create(
        username: params[:user][:username],
        password: params[:user][:username]
      )

      session[:username] = user.username

      redirect current_user_page
    else
      # TODO error
      redirect '/signup'
    end
  end
end