class AddIndexUrlTweets < ActiveRecord::Migration
  def up
    add_index :url_tweets, [:twitter_id]
  end

  def down
    remove_index :url_tweets, [:twitter_id]
  end
end
