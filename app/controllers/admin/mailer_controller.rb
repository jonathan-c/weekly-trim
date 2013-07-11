class Admin::MailerController < Admin::ApplicationController

  def posts_email()
    @user = User.last
    @posts = Post.all
    render :file => 'posts_mailer/posts_email.html.erb', :posts_mailer => 'mailer', :layout=>false
  end
  
  def post_reminder_email()
    @user = User.last
    render :file => 'posts_mailer/post_reminder_email.html.erb', :posts_mailer => 'mailer', :layout=>false
  end

end