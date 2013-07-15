desc "This task is called by the Heroku scheduler add-on"

task :send_posts => :environment do
  if Date.today.sunday?
    puts "Mailing posts..."
    Group.all.each do |group|
      group.send_posts
    end
    puts "done."
  end
end

task :send_post_reminders => :environment do
  if Date.today.friday?
    puts "Mailing post reminders..."
    Group.all.each do |group|
      group.send_post_reminders
    end
    puts "done."
  end
end