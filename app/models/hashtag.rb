class Hashtag < ActiveRecord::Base
  #  +------------+--------------+------+-----+---------+----------------+
  #  | Field      | Type         | Null | Key | Default | Extra          |
  #  +------------+--------------+------+-----+---------+----------------+
  #  | id         | int(11)      | NO   | PRI | NULL    | auto_increment |
  #  | tweet_id   | int(11)      | YES  |     | NULL    |                |
  #  | tweet__id  | bigint(20)   | YES  |     | NULL    |                |
  #  | twitter_id | int(11)      | YES  |     | NULL    |                |
  #  | hashtag    | varchar(140) | YES  |     | NULL    |                |
  #  | created_at | datetime     | NO   |     | NULL    |                |
  #  | updated_at | datetime     | NO   |     | NULL    |                |
  #  +------------+--------------+------+-----+---------+----------------+
  # attr_accessible :title, :body
  attr_accessible :tweet_id, :tweet__id, :twitter_id, :hashtag
  belongs_to :tweet

  # ハッシュタグつき投稿を取得
  def self.extract_hashtag(group_id)
    #elect hashtag, count(hashtag) as counter from hashtags group by hashtag order by counter desc;
    if Group.is_group_id?(group_id)
      tw_id_array = TwMember.make_member_id_array(group_id)
      self.select('hashtag, count(hashtag) as counter')
          .where(:twitter_id => tw_id_array)
          .group('hashtag')
          .order('counter desc')
          .limit(15)
    else
      self.select('hashtag, count(hashtag) as counter')
          .group('hashtag')
          .order('counter desc')
          .limit(15)
    end
  end

end
