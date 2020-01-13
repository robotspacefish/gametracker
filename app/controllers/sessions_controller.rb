class SessionsController < ApplicationController
  get '/login' do
    if !logged_in?
      erb :'/sessions/login'
    else
      redirect current_user_page
    end
  end

  post '/login' do
    login(params[:user])
    redirect current_user_page
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
    if valid_username?(params[:user][:username]) &&
      !username_taken?(params[:user][:username]) &&
      valid_password?(params[:user][:password])
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