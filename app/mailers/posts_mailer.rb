class PostsMailer < ActionMailer::Base
  default from: "from@example.com"
  
  def posts_email(user, posts, group)
    @user = user
    @posts = posts
    @group = group
    @posters_this_week = @group.posted_this_week
    mail(:to => @user.email, :subject => "#{@group.name} Weekly Trim")
  end
  
  def post_reminder_email(user, group)
    @user = user
    @group = group
    mail(:to => @user.email, :subject => "Don't forget to post something")
  end
  
  def admin_new_member_notification(user, group)
    @user = user
    @group = group
    mail(:to => "castillo@wow.com", :subject => "#{@user.name} just joined the #{@group.name} group!")
  end
end
