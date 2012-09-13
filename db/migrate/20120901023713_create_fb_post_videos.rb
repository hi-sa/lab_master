class CreateFbPostVideos < ActiveRecord::Migration
  def change
    create_table :fb_post_videos do |t|
      t.integer :fb_post_id
      t.string :post_id, :limit=>50
      t.string :picture, :limit=>130
      t.string :source, :limit=>150
      t.string :name, :limit=>50
      t.string :desc

      t.timestamps
    end
  end
end
