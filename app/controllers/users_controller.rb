class UsersController < ApplicationController
  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])

    if logged_in? && current_user.slug == params[:slug]
      erb :'/users/show'
    else
      @slug = params[:slug]
      erb :'/users/error'
    end
  end

  get '/users/:slug/account' do
    if !logged_in?
      redirect '/'
    else
      erb :'/users/account'
    end
  end
end