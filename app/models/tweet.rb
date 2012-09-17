class Tweet < ActiveRecord::Base
  #attr_accessible :image_url, :source, :text, :tweet_at, :tweet_id, :twitter_id
  attr_accessible :source, :text, :tweet_at, :tweet_id, :twitter_id
  
  #アソシエーションの定義
  belongs_to :tw_member

end
