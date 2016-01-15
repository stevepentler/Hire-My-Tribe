module ApplicationHelper
  def login_or_logout
    if current_user?
      link_to "Logout", logout_path, method: :delete
    else
      link_to "Login", login_path
    end
  end

  def add_or_already_in_tribe
    if @developer.in_pending_tribe?(current_pending_tribe)
      "#{@developer.name} is already in tribe"
    else
      button_to "Add to tribe", tribe_path(developer_id: @developer.id)
    end
  end
end
