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
      redirect current_user_page
    else
      erb :index
    end
  end

  get '/error' do
    erb :error
  end

  not_found do
    flash[:message] = "Page does not exist."
    redirect '/error'
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
      end
    end

    def logout!
      session.clear
    end

    def current_user_page
      "/users/#{current_user.slug}"
    end

    def signup(username, password)
      user = User.create(
        username: username,
        password: password
      )

      session[:username] = user.username
    end

    def can_sign_up?(username, password)
      error = nil
      if !User.valid_username?(username)
        error = "Invalid username."
      elsif User.username_taken?(username)
        error = "Username already in use."
      elsif !User.valid_password?(password)
        error = "Invalid password."
      end

      error
    end

    def field_is_blank?(field_value)
      field_value.blank?
    end
  end
end
