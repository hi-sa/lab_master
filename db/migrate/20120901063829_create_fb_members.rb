class CreateFbMembers < ActiveRecord::Migration
  def change
    create_table :fb_members do |t|
      t.integer :group_member_id
      t.integer :group_id
      t.integer :fb_id, :limit => 8
      t.string :fb_name, :limit => 50
      t.string :gender, :limit => 10
      t.string :image_url, :limit => 120

      t.timestamps
    end
    add_index :fb_members, [:group_member_id], :unique => true
    add_index :fb_members, [:fb_id], :unique => true
  end
end
