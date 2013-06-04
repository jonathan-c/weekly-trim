desc "This task is called by the Heroku scheduler add-on"

task :mail_posts => :environment do
  puts "Mailing posts..."
  Group.all.each do |group|
    group.mail_recent_posts
  end
  puts "done."
end