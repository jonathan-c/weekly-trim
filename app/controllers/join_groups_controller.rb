class JoinGroupsController < ApplicationController
  def create
    @group = Group.find(params[:id])
    @membership = current_user.memberships.create(group_id: @group.id, user_id: current_user.id)
    @membership.save
    redirect_to group_path(@group.id)
  end

  def destroy
    @group = Group.find(params[:id])
    current_user.leave_group(@group)
    redirect_to group_path(@group.id)
  end
end