class ErrorController < ApplicationController
  def handle
    render status: 300
  end
end
