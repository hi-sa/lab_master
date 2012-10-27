# -*- coding: utf-8 -*-
# +--------------+--------------+------+-----+---------+----------------+
# | Field        | Type         | Null | Key | Default | Extra          |
# +--------------+--------------+------+-----+---------+----------------+
# | id           | int(11)      | NO   | PRI | NULL    | auto_increment |
# | tw_member_id | int(11)      | YES  |     | NULL    |                |
# | tweet_id     | bigint(20)   | YES  | UNI | NULL    |                |
# | twitter_id   | int(11)      | YES  |     | NULL    |                |
# | text         | text         | YES  |     | NULL    |                |
# | source       | varchar(255) | YES  |     | NULL    |                |
# | tweet_at     | datetime     | YES  |     | NULL    |                |
# | created_at   | datetime     | NO   |     | NULL    |                |
# | updated_at   | datetime     | NO   |     | NULL    |                |
# +--------------+--------------+------+-----+---------+----------------+

class Tweet < ActiveRecord::Base
  attr_accessible :source, :text, :tweet_at, :tweet_id, :twitter_id
  
  #アソシエーションの定義
  belongs_to :tw_member
  has_many :url_tweets, :foreign_key => 'tweet_id'
  has_many :hashtags
  scope :new, order('tweet_at DESC')
  scope :old, order('tweet_at ASC')
  scope :top50, limit(50)
  scope :top30, limit(30)
  scope :top100, limit(100)


  def self.main_group_tweets
    # フィードを格納する配列の生成
    tweets = Array.new
    # メンバーIDを格納する配列の生成
    member_ids = Array.new

    # メイングループのGroupオブジェクトの取得
    main_groups = Group.main_groups
    # グループメンバーのIDを配列にまとめる
    main_groups.each do |group|
      group.group_members.each do |member|
        member_ids << member.id
      end

      # 最新[hoge]件のtweetを取得
      tweets << self.where(:tw_member_id => member_ids).order('tweet_at DESC').limit(30)

      member_ids = []
    end

    return tweets
  end

  # グループのIDからグループ名と所属メンバーのツイート30件を取得する
  def self.select_tweets(params)
    # 引数のグループIDのが存在した場合はその値を利用。しない場合はすべてall扱い。
    if Group.is_group_id?(params[:id])
      tw_id_array = TwMember.make_member_id_array(params[:id])
      tweets = self.search_tweets_with_params(params)
      group_name = Group.find(params[:id]).name
    else
      # all含め、全ての投稿を取得
      #tweets = self.new.top30
      tweets = self.search_alltweets_with_params(params)
      group_name = "全グループ"
    end

    return { tweets: tweets, group_name: group_name }
  end

  def self.search_tweets_with_params(params)
    if params['q']
      tweets = self.search_tweets_by_query(params[:id], params['q'], params['d'])
    elsif params['dt']
      tweets = self.search_tweets_by_date(params[:id], params['dt'], params['d'])
    elsif params['u']
      tweets = self.search_tweets_by_user(params[:id],params['u'], params['d'])
    else
      tweets = self.search_tweets(params[:id], params['d'])
    end

    return tweets
  end

  def self.search_alltweets_with_params(params)
    if params['q']
      tweets = self.search_alltweets_by_query(params['q'], params['d'])
    elsif params['dt']
      tweets = self.search_alltweets_by_date(params['dt'], params['d'])
    elsif params['u']
      tweets = self.search_alltweets_by_user(params['u'], params['d'])
    else
      tweets = self.search_alltweets(params['d'])
    end

    return tweets
  end

  def self.search_tweets_by_query(group_id, query, data)
    if data == 'url'
      query = "%#{query}%"
      sql = "SELECT t.text,tm.image_url,t.twitter_id,t.source,t.tweet_at,tm.screen_name,tm.name
             FROM url_tweets ut 
             INNER JOIN tweets t USING(tweet_id) 
             INNER JOIN tw_members tm ON t.twitter_id = tm.twitter_id 
             WHERE t.text LIKE ? 
             AND tm.group_id = ?
             ORDER BY t.tweet_at DESC 
             LIMIT 30;"
      tweets = UrlTweet.find_by_sql([sql,query,group_id])
    elsif data == 'hashtag'
      query = "%#{query}%"
      sql = "SELECT t.text,tm.image_url,t.twitter_id,t.source,t.tweet_at,tm.screen_name,tm.name
             FROM hashtags h 
             INNER JOIN tweets t ON h.tweet_id = t.id 
             INNER JOIN tw_members tm ON h.twitter_id = tm.twitter_id 
             WHERE t.text LIKE ? 
             AND tm.group_id = ?
             ORDER BY t.tweet_at DESC 
             LIMIT 30;"
      tweets = Hashtag.find_by_sql([sql,query,group_id])
    else
      query = "%#{query}%"
      sql = "SELECT t.text,tm.image_url,t.twitter_id,t.source,t.tweet_at,tm.screen_name,tm.name
             FROM tweets t 
             INNER JOIN tw_members tm USING(twitter_id) 
             WHERE t.text LIKE ? 
             AND tm.group_id = ?
             ORDER BY t.tweet_at DESC 
             LIMIT 30;"
      tweets = Tweet.find_by_sql([sql,query,group_id])
    end
    return tweets
  end

  def self.search_alltweets_by_query(query, data)
    if data == 'url'
      query = "%#{query}%"
      sql = "SELECT t.text,tm.image_url,t.twitter_id,t.source,t.tweet_at,tm.screen_name,tm.name
             FROM url_tweets ut 
             INNER JOIN tweets t USING(tweet_id) 
             INNER JOIN tw_members tm ON t.twitter_id = tm.twitter_id 
             WHERE t.text LIKE ? 
             ORDER BY t.tweet_at DESC 
             LIMIT 30;"
      tweets = UrlTweet.find_by_sql([sql,query])
    elsif data == 'hashtag'
      query = "%#{query}%"
      sql = "SELECT t.text,tm.image_url,t.twitter_id,t.source,t.tweet_at,tm.screen_name,tm.name
             FROM hashtags h 
             INNER JOIN tweets t ON h.tweet_id = t.id 
             INNER JOIN tw_members tm ON h.twitter_id = tm.twitter_id 
             WHERE t.text LIKE ? 
             ORDER BY t.tweet_at DESC 
             LIMIT 30;"
      tweets = Hashtag.find_by_sql([sql,query])
    else
      query = "%#{query}%"
      sql = "SELECT t.text,tm.image_url,t.twitter_id,t.source,t.tweet_at,tm.screen_name,tm.name
             FROM tweets t 
             INNER JOIN tw_members tm USING(twitter_id) 
             WHERE t.text LIKE ? 
             ORDER BY t.tweet_at DESC 
             LIMIT 30;"
      tweets = Tweet.find_by_sql([sql,query])
    end
    return tweets
  end

  def self.search_tweets_by_date(group_id, date, data)
    if data == 'url'
      sql = "SELECT t.text,tm.image_url,t.twitter_id,t.source,t.tweet_at,tm.screen_name,tm.name
             FROM url_tweets ut 
             INNER JOIN tweets t USING(tweet_id) 
             INNER JOIN tw_members tm ON t.twitter_id = tm.twitter_id 
             WHERE DATE_FORMAT(t.tweet_at, '%Y%m%d') = ? 
             AND tm.group_id = ?
             ORDER BY t.tweet_at DESC 
             LIMIT 30;"
      tweets = UrlTweet.find_by_sql([sql,date,group_id])
    elsif data == 'hashtag'
      sql = "SELECT t.text,tm.image_url,t.twitter_id,t.source,t.tweet_at,tm.screen_name,tm.name
             FROM hashtags h 
             INNER JOIN tweets t ON h.tweet_id = t.id 
             INNER JOIN tw_members tm ON h.twitter_id = tm.twitter_id 
             WHERE DATE_FORMAT(t.tweet_at, '%Y%m%d') = ? 
             AND tm.group_id = ?
             ORDER BY t.tweet_at DESC 
             LIMIT 30;"
      tweets = Hashtag.find_by_sql([sql,date,group_id])
    else
      sql = "SELECT t.text,tm.image_url,t.twitter_id,t.source,t.tweet_at,tm.screen_name,tm.name
             FROM tweets t 
             INNER JOIN tw_members tm USING(twitter_id) 
             WHERE DATE_FORMAT(t.tweet_at, '%Y%m%d') = ? 
             AND tm.group_id = ?
             ORDER BY t.tweet_at DESC 
             LIMIT 30;"
      tweets = Tweet.find_by_sql([sql,date,group_id])
    end

    return tweets
  end

  def self.search_alltweets_by_date(date, data)
    if data == 'url'
      sql = "SELECT t.text,tm.image_url,t.twitter_id,t.source,t.tweet_at,tm.screen_name,tm.name
             FROM url_tweets ut 
             INNER JOIN tweets t USING(tweet_id) 
             INNER JOIN tw_members tm ON t.twitter_id = tm.twitter_id 
             WHERE DATE_FORMAT(t.tweet_at, '%Y%m%d') = ? 
             ORDER BY t.tweet_at DESC 
             LIMIT 30;"
      tweets = UrlTweet.find_by_sql([sql,date])
    elsif data == 'hashtag'
      sql = "SELECT t.text,tm.image_url,t.twitter_id,t.source,t.tweet_at,tm.screen_name,tm.name
             FROM hashtags h 
             INNER JOIN tweets t ON h.tweet_id = t.id 
             INNER JOIN tw_members tm ON h.twitter_id = tm.twitter_id 
             WHERE DATE_FORMAT(t.tweet_at, '%Y%m%d') = ? 
             ORDER BY t.tweet_at DESC 
             LIMIT 30;"
      tweets = Hashtag.find_by_sql([sql,date])
    else
      sql = "SELECT t.text,tm.image_url,t.twitter_id,t.source,t.tweet_at,tm.screen_name,tm.name
             FROM tweets t 
             INNER JOIN tw_members tm USING(twitter_id) 
             WHERE DATE_FORMAT(t.tweet_at, '%Y%m%d') = ? 
             ORDER BY t.tweet_at DESC 
             LIMIT 30;"
      tweets = Tweet.find_by_sql([sql,date])
    end

    return tweets
  end

  def self.search_tweets_by_user(group_id,user,data)
    if data == 'url'
      sql = "SELECT t.text,tm.image_url,t.twitter_id,t.source,t.tweet_at,tm.screen_name,tm.name
             FROM url_tweets ut 
             INNER JOIN tweets t USING(tweet_id) 
             INNER JOIN tw_members tm ON t.twitter_id = tm.twitter_id 
             WHERE t.twitter_id = ?
             AND tm.group_id = ?
             ORDER BY t.tweet_at DESC 
             LIMIT 30;"
      tweets = UrlTweet.find_by_sql([sql,user,group_id])
    elsif data == 'hashtag'
      sql = "SELECT t.text,tm.image_url,t.twitter_id,t.source,t.tweet_at,tm.screen_name,tm.name
             FROM hashtags h 
             INNER JOIN tweets t ON h.tweet_id = t.id 
             INNER JOIN tw_members tm ON h.twitter_id = tm.twitter_id 
             WHERE t.twitter_id = ?
             AND tm.group_id = ?
             ORDER BY t.tweet_at DESC 
             LIMIT 30;"
      tweets = Hashtag.find_by_sql([sql,user,group_id])
    else
      sql = "SELECT t.text,tm.image_url,t.twitter_id,t.source,t.tweet_at,tm.screen_name,tm.name
             FROM tweets t 
             INNER JOIN tw_members tm USING(twitter_id) 
             WHERE t.twitter_id = ?
             AND tm.group_id = ?
             ORDER BY t.tweet_at DESC 
             LIMIT 30;"
      tweets = Tweet.find_by_sql([sql,user,group_id])
    end

    return tweets
  end

  def self.search_alltweets_by_user(user,data)
    if data == 'url'
      sql = "SELECT t.text,tm.image_url,t.twitter_id,t.source,t.tweet_at,tm.screen_name,tm.name
             FROM url_tweets ut 
             INNER JOIN tweets t USING(tweet_id) 
             INNER JOIN tw_members tm ON t.twitter_id = tm.twitter_id 
             WHERE t.twitter_id = ?
             ORDER BY t.tweet_at DESC 
             LIMIT 30;"
      tweets = UrlTweet.find_by_sql([sql,user])
    elsif data == 'hashtag'
      sql = "SELECT t.text,tm.image_url,t.twitter_id,t.source,t.tweet_at,tm.screen_name,tm.name
             FROM hashtags h 
             INNER JOIN tweets t ON h.tweet_id = t.id 
             INNER JOIN tw_members tm ON h.twitter_id = tm.twitter_id 
             WHERE t.twitter_id = ?
             ORDER BY t.tweet_at DESC 
             LIMIT 30;"
      tweets = Hashtag.find_by_sql([sql,user])
    else
      sql = "SELECT t.text,tm.image_url,t.twitter_id,t.source,t.tweet_at,tm.screen_name,tm.name
             FROM tweets t 
             INNER JOIN tw_members tm USING(twitter_id) 
             WHERE t.twitter_id = ?
             ORDER BY t.tweet_at DESC 
             LIMIT 30;"
      tweets = Tweet.find_by_sql([sql,user])
    end

    return tweets
  end

  def self.search_tweets(group_id,data)
    if data == 'url'
      sql = "SELECT t.text,tm.image_url,t.twitter_id,t.source,t.tweet_at,tm.screen_name,tm.name
             FROM url_tweets ut 
             INNER JOIN tweets t USING(tweet_id) 
             INNER JOIN tw_members tm ON t.twitter_id = tm.twitter_id 
             WHERE tm.group_id = ?
             ORDER BY t.tweet_at DESC 
             LIMIT 30;"
      tweets = UrlTweet.find_by_sql([sql,group_id])
    elsif data == 'hashtag'
      sql = "SELECT t.text,tm.image_url,t.twitter_id,t.source,t.tweet_at,tm.screen_name,tm.name
             FROM hashtags h 
             INNER JOIN tweets t ON h.tweet_id = t.id 
             INNER JOIN tw_members tm ON h.twitter_id = tm.twitter_id 
             WHERE tm.group_id = ?
             ORDER BY t.tweet_at DESC 
             LIMIT 30;"
      tweets = Hashtag.find_by_sql([sql,group_id])
    else
      sql = "SELECT t.text,tm.image_url,t.twitter_id,t.source,t.tweet_at,tm.screen_name,tm.name
             FROM tweets t 
             INNER JOIN tw_members tm USING(twitter_id) 
             WHERE tm.group_id = ?
             ORDER BY t.tweet_at DESC 
             LIMIT 30;"
      tweets = Tweet.find_by_sql([sql,group_id])
    end
    return tweets 
  end

  def self.search_alltweets(data)
    if data == 'url'
      sql = "SELECT t.text,tm.image_url,t.twitter_id,t.source,t.tweet_at,tm.screen_name,tm.name
             FROM url_tweets ut 
             INNER JOIN tweets t USING(tweet_id) 
             INNER JOIN tw_members tm ON t.twitter_id = tm.twitter_id 
             ORDER BY t.tweet_at DESC 
             LIMIT 30;"
      tweets = UrlTweet.find_by_sql(sql)
    elsif data == 'hashtag'
      sql = "SELECT t.text,tm.image_url,t.twitter_id,t.source,t.tweet_at,tm.screen_name,tm.name
             FROM hashtags h 
             INNER JOIN tweets t ON h.tweet_id = t.id 
             INNER JOIN tw_members tm ON h.twitter_id = tm.twitter_id 
             ORDER BY t.tweet_at DESC 
             LIMIT 30;"
      tweets = Hashtag.find_by_sql(sql)
    else
      sql = "SELECT t.text,tm.image_url,t.twitter_id,t.source,t.tweet_at,tm.screen_name,tm.name
             FROM tweets t 
             INNER JOIN tw_members tm USING(twitter_id) 
             ORDER BY t.tweet_at DESC 
             LIMIT 30;"
      tweets = Tweet.find_by_sql(sql)
    end
    return tweets 
  end

  # グループ毎のツイート数のランキングを集計する
  # FIXME: なんか冗長な処理をしているような気がする。もっと最適化できないだろうか 
  # select tm.name,count(t.twitter_id) from tweets t inner join tw_members tm using(twitter_id) where tm.group_id = 1 group by twitter_id order by count(t.twitter_id) desc;
  def self.rank_tweets_count(group_id)
    sum_tweets = self.sum_tweets(group_id)

    if Group.is_group_id?(group_id)
      # グループの総ツイート
      self.joins(:tw_member)
          .select("screen_name, count(tweets.twitter_id) as counter, round(count(tweets.twitter_id) / #{sum_tweets} * 100, 2) as pct")
          .group('tweets.twitter_id')
          .where("group_id = #{group_id}")
          .order('counter DESC')
    else
      self.joins(:tw_member)
          .select("screen_name, count(tweets.twitter_id) as counter, round(count(tweets.twitter_id) / #{sum_tweets} * 100, 2) as pct")
          .group('tweets.twitter_id')
          .order('counter DESC')
    end
  end

  # 指定したグループの総ツイート数の取得
  def self.sum_tweets(group_id = nil)
    if Group.is_group_id?(group_id)
      twitter_ids = TwMember.make_member_id_array(group_id)
      sum_tweets = self.where(:twitter_id => twitter_ids).count
    else
      sum_tweets = self.count
    end

    return sum_tweets
  end

  # 指定したグループのクライアントの比率
  # select t.source, count(t.source) as counter, round(count(t.source) / 3000 * 100, 2) 
  # from tweets t inner join tw_members using(twitter_id) 
  # where group_id = 1 group by source order by counter desc;
  def self.rank_client_ratio(group_id = nil)
    sum_tweets = self.sum_tweets(group_id)

    if Group.is_group_id?(group_id)
      self.joins(:tw_member)
          .select("source, count(tweets.source) as counter, round(count(tweets.source) / #{sum_tweets} * 100, 1) as pct")
          .group('tweets.source')
          .where("group_id = #{group_id}")
          .order('counter DESC')
    else
      self.joins(:tw_member)
          .select("source, count(tweets.source) as counter, round(count(tweets.source) / #{sum_tweets} * 100, 1) as pct")
          .group('tweets.source')
          .order('counter DESC')
    end
  end

  # 最初にツイートした日から最後にツイートした日数
  def self.datediff_from_first_to_last
    self.find_by_sql("select datediff(new,old) as diff from 
                     (select date_format(tweet_at,'%Y-%m-%d') as old from tweets order by tweet_at asc limit 1) old, 
                     (select date_format(tweet_at,'%Y-%m-%d') as new from tweets order by tweet_at desc limit 1) new")
  end

  # 一日の平均ツイート数を求める（グループ・個人単位）
  def self.calc_avg_tweet(group_id)
    # 最初に呟いた日時から最後に呟いた日時の差
    all_days = self.datediff_from_first_to_last

    if Group.is_group_id?(group_id)
      twitter_ids = TwMember.make_member_id_array(group_id)

      # 全ツイート数
      all_tweets = self.where(:twitter_id => twitter_ids).count

      # グループメンバー数
      members_num = twitter_ids.size

      avg_group_tweets = all_tweets / all_days[0][:diff]
      avg_group_member_tweets = avg_group_tweets / members_num
    else
      members_num = TwMember.count
      all_tweets = self.count
      avg_group_tweets = all_tweets / all_days[0][:diff]
      avg_group_member_tweets = avg_group_tweets / members_num
    end
    
    return { group: avg_group_tweets, person: avg_group_member_tweets }
  end


  # ツイート時間帯
  def self.plot_tweet_time(group_id)
    # select DATE_FORMAT(t.tweet_at, '%H') as hour, count(DATE_FORMAT(t.tweet_at, '%H')) as count 
    # from tweets t inner join tw_members tm on t.tw_member_id = tm.id 
    # where tm.group_id = 1 group by hour;
    if Group.is_group_id?(group_id)
      tw_id_array = TwMember.make_member_id_array(group_id)
      self.select("DATE_FORMAT(tweet_at, '%H') as hour, count(DATE_FORMAT(tweet_at, '%H')) as counter").where(:twitter_id => tw_id_array).group('hour')
    else
      self.select("DATE_FORMAT(tweet_at, '%H') as hour, count(DATE_FORMAT(tweet_at, '%H')) as counter").group('hour')
    end
  end


  # 最後に投稿した時間から何時間経過しているか
  def self.calc_transmit_time(group_id)
    # select twitter_id,screen_name,timestampdiff(MINUTE,tweet_at,now()) as transmit_time from (select tm.screen_name,t.twitter_id,tweet_at from tweets t inner join tw_members tm using(twitter_id) where tm.group_id=1 order by tweet_at desc) alias group by twitter_id;
    if Group.is_group_id?(group_id)
      tw_id_array = TwMember.make_member_id_array(group_id)
      self.find_by_sql("select twitter_id,screen_name,text,image_url,timestampdiff(MINUTE,tweet_at,now()) as transmit_time 
                        from (select tm.screen_name,t.twitter_id,tweet_at,t.text,tm.image_url
                              from tweets t 
                              inner join tw_members tm using(twitter_id) 
                              where tm.group_id = '#{group_id}'
                              order by tweet_at desc) alias 
                        group by twitter_id; ")
    else
      self.find_by_sql("select twitter_id,screen_name,text,image_url,timestampdiff(MINUTE,tweet_at,now()) as transmit_time 
                        from (select tm.screen_name,t.twitter_id,tweet_at,t.text,tm.image_url
                              from tweets t 
                              inner join tw_members tm using(twitter_id) 
                              order by tweet_at desc) alias 
                        group by twitter_id; ")

    end
  end


  # 指定されたグループのツイートが全体の何割か
  def self.calc_avg_tweet_in_all_groups(group_id)
    group_tweets = self.sum_tweets(group_id)
    all_tweets = self.sum_tweets(nil)
    ratio = group_tweets.to_f / all_tweets.to_f  * 100
    return ratio.round(1)  
  end


  # 一日の平均ツイート文字数を求める(グループ単位)
  def self.calc_avg_tweet_number_of_char(group_id)
  end

 # def avg_tweet_time 
 #   first_tweet_at = self.select('tweet_at').last
 #   last_tweet_at = self.select('tweet_at').first
 #   return "#{tweet_num}/#{first_tweet_at}/#{last_tweet_at}"
 # end

end
