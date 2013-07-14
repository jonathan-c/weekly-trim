class RemoveShareLinkFromGroups < ActiveRecord::Migration
  def up
    remove_column :groups, :share_link
  end

  def down
    add_column :groups, :share_link, :string
  end
end
