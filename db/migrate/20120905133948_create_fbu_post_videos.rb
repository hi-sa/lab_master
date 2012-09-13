class CreateFbuPostVideos < ActiveRecord::Migration
  def change
    create_table :fbu_post_videos do |t|
      t.integer :fbu_base_post_id
      t.string :link
      t.text :message
      t.string :story
      t.string :picture
      t.string :source
      t.string :name
      t.integer :object_id, :limit=>8
      t.text :desc

      t.timestamps
    end
  end
end
