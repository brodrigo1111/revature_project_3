# frozen_string_literal: true

module Authenticatable
  extend ActiveSupport::Concern

  included do
    attr_reader :current_user
  end

  private

  def authenticate_request
    if session[:user_id].nil?
      redirect_to controller: :session, action: :create
      false
    else
      @current_user = User.find(session[:user_id])
    end
  end

  def check_authenticated
    @current_user = User.find(session[:user_id]) if session[:user_id]
  end
end