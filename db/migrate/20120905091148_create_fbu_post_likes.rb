class CreateFbuPostLikes < ActiveRecord::Migration
  def change
    create_table :fbu_post_likes do |t|
      t.integer :fbu_base_post_id
      t.string :post_id, :limit=>50
      t.integer :fb_id, :limit=>8

      t.timestamps
    end
  end
end
