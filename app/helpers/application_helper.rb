module ApplicationHelper
  def login_or_logout
    if current_user?
      link_to "Logout", logout_path, id: "dropdown-font", method: :delete
    else
      link_to "Login", login_path, id: "dropdown-font"
    end
  end

  def add_or_already_in_tribe
    if @developer.in_pending_tribe?(current_pending_tribe)
      "#{@developer.name} is already in a tribe"
    elsif current_developer
      
    else
      button_to "Add #{@developer.name} to the tribe", tribe_path(developer_id: @developer.id), id: "signup-button"
    end
  end
end
