# -*- coding: utf-8 -*-
class UrlTweet < ActiveRecord::Base
 #+------------+--------------+------+-----+---------+----------------+
 #| Field      | Type         | Null | Key | Default | Extra          |
 #+------------+--------------+------+-----+---------+----------------+
 #| id         | int(11)      | NO   | PRI | NULL    | auto_increment |
 #| tweet_id   | bigint(20)   | YES  |     | NULL    |                |
 #| twitter_id | int(11)      | YES  | MUL | NULL    |                |
 #| site_url   | varchar(255) | YES  |     | NULL    |                |
 #| site_title | text         | YES  |     | NULL    |                |
 #| created_at | datetime     | NO   |     | NULL    |                |
 #| updated_at | datetime     | NO   |     | NULL    |                |
 #+------------+--------------+------+-----+---------+----------------+
  attr_accessible :tweet_id, :twitter_id, :site_url, :site_title

  belongs_to :tweet, :foreign_key => 'tweet_id'

  def self.get_recent_tweets(group_id)
    #self.order('tweet_id desc').limit(10) 
    if Group.is_group_id?(group_id)
      self.find_by_sql("select ut.site_title,ut.site_url,t.tw_member_id,t.tweet_at,t.twitter_id,tm.screen_name,tm.image_url,tm.group_id
                        from url_tweets ut 
                        inner join tweets t using(tweet_id) 
                        inner join tw_members tm on t.tw_member_id = tm.id 
                        where ut.site_title != 'ERROR'
                        and tm.group_id = #{group_id}
                        order by t.tweet_at desc 
                        limit 10;")
    else
      self.find_by_sql("select ut.site_title,ut.site_url,t.tw_member_id,t.tweet_at,t.twitter_id,tm.screen_name,tm.image_url
                        from url_tweets ut 
                        inner join tweets t using(tweet_id) 
                        inner join tw_members tm on t.tw_member_id = tm.id 
                        where ut.site_title != 'ERROR'
                        order by t.tweet_at desc 
                        limit 10;")
    end
  end

  


end
