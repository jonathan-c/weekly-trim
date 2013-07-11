class GroupsController < ApplicationController
  before_filter :find_group, :only => [:show, :edit, :update, :email]
  before_filter :check_permission, :only => [:show]
  
  def new
    @group = Group.new
  end

  def create
    @group = Group.new(name: params[:group]["name"])
    @group.save
    @group.memberships.create(user_id: params[:group]["user_id"], group_id: @group.id, admin: true)
    redirect_to group_path(@group.id)
  end

  def show
    if session[:auto_join] == "y"
      join_groups_create_path(@group.id)
    end   
  end

  def edit
  end

  def update
    @group.update_attributes(name: params[:group]["name"])
    redirect_to group_path(@group.id)
  end

  def destroy
    
  end
  
  def email
    @group.send_posts
    redirect_to @group
  end
  
  def join
    @group = Group.find_by_token(params[:token])
    if current_user && current_user.member?(@group)
      redirect_to group_path(@group)
    end
  end
  
  private
  
    def find_group
      if params[:group_id]
        @group = Group.find(params[:group_id])
      else
        @group = Group.find(params[:id])
      end
    end
    
    def check_permission
      if current_user.nil?
        redirect_to root_path 
      # elsif !current_user.member?(@group)
      #   redirect_to '/pages/no_access'
      end
    end

end
