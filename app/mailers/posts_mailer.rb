class PostsMailer < ActionMailer::Base
  default from: "from@example.com"
  
  def posts_email(user, posts)
    @user = user
    @posts = posts
    # mail(:to => user.email, :subject => "Weekly Trim")
    mail(:to => "castillo@wow.com", :subject => "Weekly Trim")
    # @members = members
    #     @members.each do |member|
    #       mail(:to => member.email, :subject => "Weekly Trim")
    #     end
  end
end