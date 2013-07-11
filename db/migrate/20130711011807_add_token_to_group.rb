class AddTokenToGroup < ActiveRecord::Migration
  def change
    add_column :groups, :token, :string
  end
end
