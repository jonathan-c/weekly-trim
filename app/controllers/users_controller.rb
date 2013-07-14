class UsersController < ApplicationController
  before_filter :find_group
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(params[:user])
    redirect_to edit_group_user_path(@group, @user), notice: "Update successful"
  end
  
  private
  
    def find_group
      @group = Group.find(params[:group_id])
    end
end
