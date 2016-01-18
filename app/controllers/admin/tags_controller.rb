class Admin::TagsController < ApplicationController
  
  def index
    @tags = Tag.all
  end 

  def new
    @tag = Tag.new
  end 

  def create
    @tag = Tag.create(tag_params)
    redirect_to admin_tags_path
  end 

  def edit
    @tag = Tag.find(params[:id])
  end

  def update
    @tag = Tag.find(params[:id])
    if @tag.update(tag_params)
      flash[:notice] = "Tag has been updated!"
      redirect_to admin_tags_path
    else 
      flash[:error] = "Tag has not been updated!"
      render :edit
    end
  end

  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy
    redirect_to admin_tags_path
  end  

  private

  def tag_params
    params.require(:tag).permit(:name)
  end 
end 