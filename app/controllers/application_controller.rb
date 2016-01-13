class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :initialize_tribes_session, :all_specialties

  def initialize_tribes_session
    session[:tribe] ||= []
  end

  def all_specialties
    @specialties = Specialty.all
  end

  def disable_navbar
    @disable_navbar = true
  end

end
