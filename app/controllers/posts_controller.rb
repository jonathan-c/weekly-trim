class PostsController < ApplicationController
  def index
  end

  def new
    @group = Group.find(params[:group_id])
    @post = Post.new
  end

  def create
    @group = Group.find(params[:group_id])
    @post = Post.create(user_id: current_user.id, group_id: @group.id, title: params[:post]["title"], url: params[:post]["url"])
    redirect_to group_path(@group.id)
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
