# -*- coding: utf-8 -*-
# +--------------------+------------------+------+-----+---------+----------------+
# | Field              | Type             | Null | Key | Default | Extra          |
# +--------------------+------------------+------+-----+---------+----------------+
# | id                 | int(11)          | NO   | PRI | NULL    | auto_increment |
# | fb_member_id       | int(11)          | YES  |     | NULL    |                |
# | fb_group_member_id | int(10) unsigned | YES  |     | NULL    |                |
# | post_id            | varchar(50)      | YES  | UNI | NULL    |                |
# | fb_id              | bigint(20)       | YES  |     | NULL    |                |
# | fb_name            | varchar(50)      | YES  |     | NULL    |                |
# | group_id           | bigint(20)       | YES  |     | NULL    |                |
# | group_name         | varchar(50)      | YES  |     | NULL    |                |
# | message            | text             | YES  |     | NULL    |                |
# | created_time       | varchar(30)      | YES  |     | NULL    |                |
# | updated_time       | varchar(30)      | YES  |     | NULL    |                |
# | created_at         | datetime         | NO   |     | NULL    |                |
# | updated_at         | datetime         | NO   |     | NULL    |                |
# +--------------------+------------------+------+-----+---------+----------------+
class FbPost < ActiveRecord::Base
  attr_accessible :fb_member_id, :post_id, :fb_id, :fb_name, :group_id, :group_name, :message, :created_time, :updated_time

  # アソシエーション
  belongs_to :fb_member
  belongs_to :fb_group_member
  has_one :fb_post_picture
  has_one :fb_post_video
  has_many :fb_post_comments
  has_many :fb_post_likes

  scope :new, order('created_time DESC')
  scope :old, order('created_time ASC')
  scope :top50, limit(50)
  scope :top30, limit(30)
  scope :top100, limit(100)
  scope :include_url, where('message LIKE "%http%"')
  scope :one_group, lambda {|group| where(:group_id => group)}
  paginates_per 20 #Kaminari(ページネーション)の設定。1ページに表示する件数

  # 引数に指定されたグループID(Facebook)の投稿を取得する
  def self.recent_posts(group_id)
    posts = self.where(:group_id => group_id).order('created_time DESC').limit(30)
    return posts
  end
  
  # 投稿の取得
  def self.select_posts(params)
    if FbGroup.is_group_id?(params[:group_id])
      posts = self.search_posts_with_params(params) 
    else
      posts = self.search_allposts_with_params(params) 
    end

    return posts
  end

  # 取得投稿をパラメータで振り分け
  def self.search_posts_with_params(params)
    if params['q']
      posts = self.search_posts_by_query(params[:group_id], params['q'], params['d'])
    elsif params['dt']
      posts = self.search_posts_by_date(params[:group_id], params['dt'], params['d'])
    elsif params['u']
      posts = self.search_posts_by_user(params[:group_id],params['u'], params['d'])
    else
      posts = self.search_posts(params[:group_id], params['d'])
    end

    return posts
  end

  def self.search_allposts_with_params(params)
    if params['q']
      posts = self.search_allposts_by_query(params['q'], params['d'])
    elsif params['dt']
      posts = self.search_allposts_by_date(params['dt'], params['d'])
    elsif params['u']
      posts = self.search_allposts_by_user(params['u'], params['d'])
    else
      posts = self.search_allposts(params['d'])
    end

    return posts
  end

  def self.search_posts(group_id,data)
    if data == 'url'
      posts = self.one_group(group_id).include_url.new.top50
    else
      posts = self.one_group(group_id).new.top50
    end

    return posts
  end

  def self.search_allposts(data)
    if data == 'url'
      posts = self.include_url.new.top50
    else
      posts = self.new.top50
    end

    return posts
  end

  def self.search_posts_by_query(group_id,query,data)
    if data == 'url'
      posts = self.where('message LIKE ?',"%#{query}%").one_group(group_id).include_url.new.top50
    else
      posts = self.where('message LIKE ?',"%#{query}%").one_group(group_id).new.top50
    end

    return posts
  end

  def self.search_allposts_by_query(query,data)
    if data == 'url'
      posts = self.where('message LIKE ?',"%#{query}%").include_url.new.top50
    else
      posts = self.where('message LIKE ?',"%#{query}%").new.top50
    end

    return posts
  end

  def self.search_posts_by_date(group_id,date,data)
    if data == 'url'
      posts = self.where("DATE_FORMAT(created_time, '%Y%m%d') = ?",date)
                  .one_group(group_id).include_url.new.top50
    else
      posts = self.where("DATE_FORMAT(created_time, '%Y%m%d') = ?",date)
                  .one_group(group_id).new.top50
    end

    return posts
  end

  def self.search_allposts_by_date(date,data)
    if data == 'url'
      posts = self.where("DATE_FORMAT(created_time, '%Y%m%d') = ?",date).include_url.new.top50
    else
      posts = self.where("DATE_FORMAT(created_time, '%Y%m%d') = ?",date).new.top50
    end

    return posts
  end

  def self.search_posts_by_user(group_id,user,data)
    if data == 'url'
      posts = self.where('fb_id = ?',user).one_group(group_id).include_url.new.top50
    else
      posts = self.where('fb_id = ?',user).one_group(group_id).new.top50
    end

    return posts
  end

  def self.search_allposts_by_user(user,data)
    if data == 'url'
      posts = self.where('fb_id = ?',user).include_url.new.top50
    else
      posts = self.where('fb_id = ?',user).new.top50
    end

    return posts
  end

  # グループへの投稿数ランキング
  def self.listup_post_users(group_id)
    if FbGroup.is_group_id?(group_id)
      post_users = self.select('fb_name, fb_id, count(fb_id) as counter')
                       .where(:group_id => group_id)
                       .group('fb_id')
                       .order('counter DESC')
    else
      post_users = self.select('fb_name, fb_id, count(fb_id) as counter')
                       .group('fb_id')
                       .order('counter DESC')
    end
  end

  #全ての投稿数
  def self.count_posts_num(group_id)
    if FbGroup.is_group_id?(group_id)
      post_count = self.where(:group_id => group_id).count
    else
      post_count = self.count
    end
  end

  # 今月の投稿数
  def self.count_this_month_posts_num(group_id)
    t_month = Date.new(Date.today.year, Date.today.mon, 1)
    t_month = t_month.strftime('%Y%m')
    if FbGroup.is_group_id?(group_id)
      post_count = self.where(:group_id => group_id).where("DATE_FORMAT(created_time, '%Y%m') = #{t_month}").count
    else
      post_count = self.where("DATE_FORMAT(created_time, '%Y%m%d') = #{t_month}").count
    end
  end

  # 先月の投稿数
  def self.count_last_month_posts_num(group_id)
    l_month = Date.new(Date.today.year, Date.today.mon-1, 1)
    l_month = l_month.strftime('%Y%m')
    if FbGroup.is_group_id?(group_id)
      post_count = self.where(:group_id => group_id).where("DATE_FORMAT(created_time, '%Y%m') = #{l_month}").count
    else
      post_count = self.where("DATE_FORMAT(created_time, '%Y%m%d') = #{l_month}").count
    end
  end

  #写真集
  def self.extract_photos(group_id)
  end

  #URLの抽出
  def self.extract_url_posts(group_id)
  end

  #アップロードファイル集
  def self.extract_uploaded_files(group_id)
  end

end
