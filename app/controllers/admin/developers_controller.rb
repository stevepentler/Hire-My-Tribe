class Admin::DevelopersController < Admin::BaseController
  def rate
    @developer = Developer.find params[:dev_id]
    @developer.update_attribute(:skills_rating,params[:rating][:rating])
    redirect_to developer_path(@developer)
  end
end
