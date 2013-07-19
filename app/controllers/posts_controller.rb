class PostsController < ApplicationController
  before_filter :check_permission
  
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
    @group = Group.find(params[:group_id])
    @post = Post.find(params[:id])
  end

  def update
    @group = Group.find(params[:group_id])
    @post = Post.find(params[:id])
    @post.update_attributes(params[:post])
    redirect_to group_path(@group.id)
  end

  def destroy
  end
  
  private
  
    def check_permission
      if current_user.nil?
        redirect_to root_path 
      end
    end
end
