class AddIndexTweets < ActiveRecord::Migration
  def up
    add_index :tweets, [:twitter_id, :tweet_at]
  end

  def down
    remove_index :tweets, [:twitter_id, :tweet_at]
  end
end
