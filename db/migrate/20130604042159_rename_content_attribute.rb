class RenameContentAttribute < ActiveRecord::Migration
  def up
    rename_column :posts, :content, :title
  end

  def down
    rename_column :posts, :title, :content
  end
end
