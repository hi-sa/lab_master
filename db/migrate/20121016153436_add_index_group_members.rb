class AddIndexGroupMembers < ActiveRecord::Migration
  def up
    add_index :group_members, [:fb_id, :twitter_id]
  end

  def down
  end
end
