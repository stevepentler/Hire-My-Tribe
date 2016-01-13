module ApplicationHelper
  def login_or_logout
    if current_user?
      "Logout"
    else
      "Login"
    end
  end
end
