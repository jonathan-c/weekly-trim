class AddLatestPostsEmailToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :last_email_sent, :timestamp
  end
end
