desc "This task is called by the Heroku scheduler add-on"

task :mail_posts => :environment do
  if Date.today.sunday?
    puts "Mailing posts..."
    Group.all.each do |group|
      group.mail_recent_posts
    end
    puts "done."
  end
end

# task :mail_post_reminder => :environment do
#   if Date.today.saturday?
#     puts "Mailing post reminders..."
#     Group.all.each do |group|
#       group.mail_post_reminders
#     end
#     puts "done."
#   end
# end