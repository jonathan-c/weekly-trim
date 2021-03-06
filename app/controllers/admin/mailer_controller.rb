class Admin::MailerController < Admin::ApplicationController

  def posts_email()
    @user = User.last
    @posts = Post.all
    @group = Group.last
    @posters_this_week = @group.posted_this_week
    render :file => 'posts_mailer/posts_email.html.erb', :posts_mailer => 'mailer', :layout=>false
  end
  
  def post_reminder_email()
    @user = User.last
    @group = Group.first
    render :file => 'posts_mailer/post_reminder_email.html.erb', :posts_mailer => 'mailer', :layout=>false
  end

end