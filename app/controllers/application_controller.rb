require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get "/" do
    erb :index
  end
  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      @current_user = "test"
      # @current_user ||= User.find_by(username: session[:username] if session[:username])
    end

    def logout!
      session.clear
    end
  end
end
