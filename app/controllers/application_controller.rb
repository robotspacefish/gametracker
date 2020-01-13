require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "s&M9V4CUEhoRu&hbfKdi#S70oXIx#EpiV%r%2ZH1m9ZI8%848Shcttd3xW#K"
  end

  get "/" do
    if logged_in?
      redirect "/users/#{current_user.slug}"
    else
      erb :index
    end
  end

  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by(username: session[:username]) if session[:username]
    end

    def login(params)
      user = User.find_by(username: params[:username])

      if user && user.authenticate(params[:password])
        session[:username] = user.username
      else
        redirect '/login'
      end
    end

    def logout!
      session.clear
    end

    def current_user_page
      "/users/#{current_user.slug}"
    end

    def valid_username?(username)
      # \s whitespace, \W Any non-word character
      !username.blank? &&
      !username.match?(/\s/) &&
      !username.match?(/\W/)
    end

    def valid_password?(password)
      !password.blank? &&
      !password.match?(/\s/)
    end

    def username_not_taken?(username)
      !!User.find_by(username: username)
    end
  end
end
