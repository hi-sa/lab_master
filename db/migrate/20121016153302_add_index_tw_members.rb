class AddIndexTwMembers < ActiveRecord::Migration
  def up
    add_index :tw_members, [:group_id]
  end

  def down
    remove_index :tw_members, [:group_id]
  end
end
