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
      # TODO
      user = User.create(username: "jess") # for testing
      redirect "/users/#{user.slug}" # replace with current_user.slug
    else
      erb :index
    end
  end

  get '/login' do
    erb :'/sessions/login'
  end

  get '/logout' do
    logout!
    redirect '/'
  end

  get '/signup' do
    erb :'/sessions/signup'
  end

  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by(username: session[:username]) if session[:username]
    end
    end

    def logout!
      session.clear
    end
  end
end
