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

  private

  def tag_params
    params.require(:tag).permit(:name)
  end 
end 