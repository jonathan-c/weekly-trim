class UsersController < ApplicationController
  before_filter :find_group
  before_filter :check_permission
  
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(params[:user])
    redirect_to edit_group_user_path(@group, @user), notice: "Update successful"
  end
  
  private
  
  private
  
    def find_group
      @group = Group.find(params[:group_id])
    end
    
    def check_permission
      if current_user != User.find(params[:id]) || current_user.nil?
        redirect_to root_path
      end
    end
end
