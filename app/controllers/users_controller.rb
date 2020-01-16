class UsersController < ApplicationController
  get '/users' do
    @users = User.all
    erb :'users/index'
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

          current_user.update(username: params[:user][:username])

          session[:username] = current_user.username

          redirect to current_user_page
        else
          # TODO ERROR: new username invalid
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
         # TODO ERROR: new password invalid
          # redirect to "#{current_user_page}/account"
          "Invalid password"
      end


    end
  end

  delete '/users/:slug/account' do
    if !logged_in? || current_user.slug != params[:slug]
      redirect '/'
    else
      # if current_user.slug != params[:slug]
      #   #TODO ERROR
      #   "You cannot "
      # else
        current_user.delete
        redirect '/'
      # end

    end
  end
end