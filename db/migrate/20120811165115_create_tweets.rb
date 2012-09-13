class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.integer :tw_member_id
      t.integer :tweet_id, :limit=>8
      t.integer :twitter_id
      t.text :text
      t.string :source
      t.datetime :tweet_at

      t.timestamps
    end
    add_index :tweets, [:tweet_id], :unique => true
  end
end
