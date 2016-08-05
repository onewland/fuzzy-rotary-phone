class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  rescue_from StandardError do |e|
    render json: { text: "There was an error processing your request"}, status: 500
  end
end
