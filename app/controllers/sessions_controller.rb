class SessionsController < ApplicationController
  use Rack::Flash, :sweep => true

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

      flash[:message] = "There was a problem logging you in. Make sure you have the correct username and password."
      redirect '/login'
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
    if error = can_sign_up?(params[:user][:username], params[:user][:password])

      flash[:message] = error

      redirect '/signup'
    else
      signup(params[:user][:username], params[:user][:password])

      redirect current_user_page
    end
  end
end