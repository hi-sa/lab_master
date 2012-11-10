class CreateRegisteredBlogs < ActiveRecord::Migration
  def change
    create_table :registered_blogs do |t|
      t.integer :twitter_id
      t.string :title
      t.string :url, :limit=>200
      t.string :feed_url
      t.boolean :crawl_flg
      t.timestamps
    end
  end
end
