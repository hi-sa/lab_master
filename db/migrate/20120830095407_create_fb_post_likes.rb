class CreateFbPostLikes < ActiveRecord::Migration
  def change
    create_table :fb_post_likes do |t|
      t.integer :fb_post_id
      t.string :post_id, :limit=>50
      t.integer :fb_id, :limit=>8

      t.timestamps
    end
  end
end
