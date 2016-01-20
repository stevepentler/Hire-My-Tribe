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

  def project_actions(status)
    case status
    when "Pending"
      concat( link_to "Submit Payment", new_contractor_project_charge_path(@project), id: "checkout-button")
    when "Paid & Active"
      concat( link_to "Complete Project", contractor_project_complete_path(@project), id: "checkout-button", method: :patch)
      concat(" ")
      concat( link_to "Cancel Project", contractor_project_cancel_path(@project), id: "checkout-button", method: :patch)
    end
  end

  def language_dropdown(f,specialty)
    f.select("#{specialty.url_name}_lang", options_for_select(all_tags.map{|x| x.name}))
  end
end
