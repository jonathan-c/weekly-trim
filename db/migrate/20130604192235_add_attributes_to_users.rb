class AddAttributesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :subscribed, :boolean, :default => true
    add_column :users, :post_reminder, :boolean, :default => true
  end
end
