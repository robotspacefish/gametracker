class UsersController < ApplicationController
  use Rack::Flash

  get '/users' do
   if !logged_in?
    redirect '/login'
   else
      @users = User.all.order(:username)
      erb :'users/index'
   end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])

    if logged_in? && current_user.slug == params[:slug]
      erb :'/users/show'
    else
      @msg = ""
      if @user
        @msg = "You must be logged in as #{@user.username} to view this page."
      else
        @msg = "User #{params[:slug]} does not exist. <a href=\"/signup\">Would you like to make an account with this name?</a></h2>"
      end
      erb :error
    end
  end

  get '/users/:slug/account' do
    if !logged_in?
      redirect '/'
    elsif current_user.slug != params[:slug]
      redirect to "#{current_user_page}/account"
    else
      erb :'/users/account'
    end
  end

  patch '/users/:slug/account/update_username' do
    if !logged_in?
      redirect '/'
    else
      if current_user.should_update_username?(params[:user][:username])

        if User.can_update_username?(params[:user][:username])

          current_user.update_username(params[:user][:username])

          session[:username] = current_user.username

          redirect to current_user_page
        else
          flash[:message] = "That name is invalid."
          redirect to "#{current_user_page}/account"
        end
      end
    end
  end

  patch '/users/:slug/account/update_password' do
    if !logged_in?
      redirect '/'
    else
      if !field_is_blank?(params[:user][:password]) && User.can_update_password?(params[:user][:password])

        current_user.update_password(params[:user][:password])

        redirect to current_user_page
      else
        flash[:message] = "That password is invalid."
        redirect to "#{current_user_page}/account"
      end


    end
  end

  delete '/users/:slug/account' do
    if !logged_in? || current_user.slug != params[:slug]
      redirect '/'
    else
      UsersGamePlatform.delete_by_user_id(current_user.id)
      current_user.delete

      flash[:message] = "You have successfully deleted your account. Goodbye!"

      redirect '/'
    end
  end

  delete '/users/:slug/game' do
     if !logged_in? || current_user.slug != params[:slug]
      redirect '/'
    else
      current_user.delete_game_from_library(params[:game][:platform_id], params[:game][:game_id])

      flash[:message] = "#{params[:game][:title]} for #{params[:game][:platform_name]} was removed."
      redirect current_user_page
    end
  end
end