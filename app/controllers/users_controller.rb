class UsersController < ApplicationController
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
    # TODO handle someone trying to go directly to an account page
    # someone else's existing account
    # a nonexistent account
    @slug = params[:slug]
    if !logged_in?
      redirect '/'
    elsif current_user.slug != @slug
      erb :error
    else
      erb :'/users/account'
    end
  end

  patch '/users/:slug/account' do
    if !logged_in?
      redirect '/'
    else
      # update username
      if params[:user][:username] != current_user.username
        valid_username = if valid_username?(params[:user][:username]) &&
          !username_taken?(params[:user][:username])

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