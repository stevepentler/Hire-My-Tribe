module ApplicationHelper
  def login_or_logout(id="dropdown-font")
    if current_user?
      link_to "Logout", logout_path, id: id, method: :delete
    else
      link_to "Login", login_path, id: id
    end
  end

  def add_or_already_in_tribe
    if @developer.in_pending_tribe?(current_pending_tribe)
      "#{@developer.name} is already in a tribe"
    elsif current_developer

    else
      button_to "Add #{@developer.name} to the tribe",
                tribe_path(developer_id: @developer.id),
                id: "signup-button"
    end
  end

  def contractor_name(contractor)
    if contractor.company_name.empty?
      contractor.first_name + " " + contractor.last_name
    else
      contractor.company_name
    end
  end

  def current_contractors_project?(project)
    project.contractor == current_contractor
  end
end
