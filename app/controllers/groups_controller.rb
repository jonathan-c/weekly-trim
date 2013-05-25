class GroupsController < ApplicationController
  before_filter :find_group, :only => [:show, :edit, :update]
  
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
    
  end

  def edit
  end

  def update
    @group.update_attributes(name: params[:group]["name"])
    redirect_to group_path(@group.id)
  end

  def destroy
    
  end
  
  private
  
    def find_group
      @group = Group.find(params[:id])
    end

end
