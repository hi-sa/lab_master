class CreateFbPostPictures < ActiveRecord::Migration
  def change
    create_table :fb_post_pictures do |t|
      t.integer :fb_post_id
      t.string :post_id, :limit=>50
      t.string :picture, :limit=>130
      t.string :object_id, :limit=>20

      t.timestamps
    end
  end
end
