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
      if !User.valid_username?(params[:user][:username])
        flash[:message] = "Invalid username."
      elsif User.username_taken?(params[:user][:username])
        flash[:message] = "Username already in use."
      elsif !User.valid_password?(params[:user][:password])
        flash[:message] = "Invalid password."
      else
        flash[:message] = "There was a problem signing you up. Please try again."
      end

      redirect '/signup'
    end
  end
end