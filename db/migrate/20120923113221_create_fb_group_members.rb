class CreateFbGroupMembers < ActiveRecord::Migration
  def change
    create_table :fb_group_members do |t|
      t.column :group_id, 'integer unsigned'
      t.column :fb_id, 'bigint unsigned', :limit => 8
      t.column :fb_group_id, 'integer unsigned'
      t.string :fb_name, :limit => 50
      t.string :gender, :limit => 10
      t.string :image_url, :limit => 120

      t.timestamps
    end
    add_index :fb_group_members, [:fb_id], :unique => true
  end
end
