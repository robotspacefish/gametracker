require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, $secret_session_key
  end

  get "/" do
    if logged_in?
      # TODO
      user = User.create(username: "jess") # for testing
      redirect "/users/#{user.slug}" # replace with current_user.slug
    else
      erb :index
    end
  end

  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      @current_user = true
      # @current_user ||= User.find_by(username: session[:username] if session[:username])
    end

    def logout!
      session.clear
    end
  end
end
