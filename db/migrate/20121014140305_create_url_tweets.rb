class CreateUrlTweets < ActiveRecord::Migration
  def change
    create_table :url_tweets do |t|
      t.integer :tweet_id, :limit=>8
      t.integer :twitter_id
      t.string :site_url
      t.text :site_title

      t.timestamps
    end
  end
end
