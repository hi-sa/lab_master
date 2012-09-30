class CreateFbuBasePosts < ActiveRecord::Migration
  def change
    create_table :fbu_base_posts do |t|
      t.integer :fb_member_id
      t.string :post_id, :limit=>50
      t.integer :fb_id, :limit=>8
      t.string :post_type, :limit=>10
      t.string :created_time, :limit=>30
      t.string :updated_time, :limit=>30

      t.timestamps
    end
    add_index :fbu_base_posts, [:post_id], :unique => true
  end
end
