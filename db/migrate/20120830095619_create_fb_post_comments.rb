class CreateFbPostComments < ActiveRecord::Migration
  def change
    create_table :fb_post_comments do |t|
      t.integer :fb_post_id
      t.string :post_id, :limit=>50
      t.string :comment_id, :limit=>60
      t.integer :fb_id, :limit=>8
      t.text :message
      t.string :created_time, :limit=>30

      t.timestamps
    end
  end
end
