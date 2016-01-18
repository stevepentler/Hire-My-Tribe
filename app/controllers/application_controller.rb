class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :current_pending_tribe, :all_specialties

  after_action :stash_pending_tribe

  helper_method :current_user?,
                :current_contractor,
                :current_pending_tribe,
                :current_specialty,
                :developer_path,
                :all_specialties,
                :current_developer

  def developer_path(dev = nil)
    if dev
      "/developers/#{dev.id}"
    else
      "/developer"
    end
  end

  def current_specialty
    @current_specialty ||=
            Specialty.find(session[:specialty]) if session[:specialty]
  end

  def current_pending_tribe
    @pending_tribe ||= PendingTribe.new(session[:tribe])
  end

  def stash_pending_tribe
    session[:tribe] = current_pending_tribe.developer_ids
  end

  def all_specialties
    @specialties = Specialty.all
  end

  def disable_navbar
    @disable_navbar = true
  end

  def current_user?
    (current_developer || current_contractor) || current_admin
  end

  def current_developer
    @current_developer ||=
          Developer.find(session[:developer_id]) if session[:developer_id]
  end

  def current_contractor
    @current_contractor ||=
          Contractor.find(session[:contractor_id]) if session[:contractor_id]
  end

  def current_admin
    @current_admin ||= Admin.find(session[:admin_id]) if session[:admin_id]
  end
end
