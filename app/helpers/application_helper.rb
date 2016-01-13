module ApplicationHelper
  def login_or_logout
    if current_user?
      "Logout"
    else
      link_to "Login", login_path
    end
  end
end
