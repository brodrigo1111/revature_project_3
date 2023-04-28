class UserController < ApplicationController
  include Authenticatable
  def create
    check_authenticated
    if @current_user
      redirect_to controller: :error, action: :handle
      return
    end
    user = User.new(username: params[:username], password: params[:password])
    if user.save
      user = User.where(username: params[:username]).first
      session[:user_id] = user.id
      redirect_to root_path
    else
      redirect_to controller: :error, action: :handle
    end
  end
end
