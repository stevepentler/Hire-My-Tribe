class Admin::TagsController < ApplicationController
  
  def index
    @tags = Tag.all
  end 

  def new
    @tag = Tag.new
  end 

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      flash[:notice] = "#{@tag.name} Tag Added!"
      redirect_to admin_tags_path
    else 
      flash[:error] = @tag.errors.full_messages.join(", ")
      redirect_to new_admin_tag_path
    end
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
      flash[:error] = @tag.errors.full_messages.join(", ")
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