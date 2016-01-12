class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :initialize_tribes_session

  def initialize_tribes_session
    session[:tribe] ||= []
  end
end
