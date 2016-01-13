class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :current_pending_tribe, :all_specialties

  helper_method :current_user?

  def current_pending_tribe
    session[:tribe] ||= []
    @ptribe = PendingTribe.new(session[:tribe])
  end

  def all_specialties
    @specialties = Specialty.all
  end

  def disable_navbar
    @disable_navbar = true
  end

  def current_user?
    current_developer || current_contractor
  end

  def current_developer
    @current_developer ||= Contractor.find(session[:developer_id]) if session[:developer_id]
  end

  def current_contractor
    @current_contractor ||= Contractor.find(session[:contractor_id]) if session[:contractor_id]
  end
end
