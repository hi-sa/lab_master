# -*- coding: utf-8 -*-
class FbPost < ActiveRecord::Base
  attr_accessible :fb_member_id, :post_id, :fb_id, :fb_name, :group_id, :group_name, :message, :created_time, :updated_time

  # アソシエーション
  belongs_to :fb_member
  belongs_to :fb_group_member
  has_one :fb_post_picture
  has_one :fb_post_video
  has_many :fb_post_comments
  has_many :fb_post_likes


  # 引数に指定されたグループID(Facebook)の最近の投稿50件を習得する
  def self.recent_posts(group_id)
    posts = FbPost.where(:group_id => group_id).order('created_time DESC').limit(30)
    return posts
  end

end
