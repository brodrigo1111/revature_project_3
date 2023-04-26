class SessionController < ApplicationController
  def new
  end
  def create
    user = User.where(username: params['username']).first
    unless user
      render :bad
    else
      if user.authenticate(params['password'])
        session[:user_id] = user.id
        redirect_to root_path
      end
    end
  end
  def bad
  end
  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end