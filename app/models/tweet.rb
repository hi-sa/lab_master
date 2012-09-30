class Tweet < ActiveRecord::Base
  #attr_accessible :image_url, :source, :text, :tweet_at, :tweet_id, :twitter_id
  attr_accessible :source, :text, :tweet_at, :tweet_id, :twitter_id
  
  #アソシエーションの定義
  belongs_to :tw_member


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

end
