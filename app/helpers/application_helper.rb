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

  def contractor_summary(contractor)
    content_tag :div, class: "row" do
      concat(image_tag( contractor.logo , height: "100px", id: "contractor-#{contractor.id}-logo"))
      concat(link_to(contractor_name(contractor),contractor_path(contractor_id: contractor.id), class: "login-link"))
    end
  end

  def contractor_name(contractor)
    if contractor.company_name.empty?
      contractor.first_name + " " + contractor.last_name
    else
      contractor.company_name
    end
  end
end
