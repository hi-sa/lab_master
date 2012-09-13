class CreateFbPosts < ActiveRecord::Migration
  def change
    create_table :fb_posts do |t|
      t.integer :fb_member_id
      t.string :post_id, :limit=>50
      t.integer :fb_id, :limit=>8
      t.string :fb_name, :limit=>50
      t.integer :group_id, :limit=>8
      t.string :group_name, :limit=>50
      t.text :message
      t.string :created_time, :limit=>30
      t.string :updated_time, :limit=>30

      t.timestamps
    end
    add_index :fb_posts, [:post_id], :unique => true
  end
end
