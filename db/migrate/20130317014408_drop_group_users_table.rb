class DropGroupUsersTable < ActiveRecord::Migration
  def up
    drop_table :group_users
  end

  def down
  end
end
