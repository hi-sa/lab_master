class CreateHashtags < ActiveRecord::Migration
  def change
    create_table :hashtags do |t|
      t.integer :tweet_id #tweetテーブルへの外部キー
      t.integer :tweet__id, :limit=>8 #ツイートのID
      t.integer :twitter_id
      t.string :hashtag, :limit=>140
      t.timestamps
    end
  end
end
