# -*- coding: utf-8 -*-
class GroupMember < ActiveRecord::Base
  attr_accessible :blog_url, :fb_id, :group_id, :twitter_id, :name, :image_url

  #アソシエーションの定義
  belongs_to :tw_member
  belongs_to :fb_member
  belongs_to :blog_member
  belongs_to :group
  #has_and_belongs_to_many :groups

  # 指定されたグループに所属するメンバーのtwitter_idを配列で返す
  def self.array_twitter_ids(group_id)
    id_array = Array.new
    
    group_members = self.find_all_by_group_id(group_id)
    group_members.each do |member|
      id_array << member.twitter_id
    end
    return id_array
  end

  def ins_method
    hoge = "hoge"
    return
  end

  def self.cls_method
    return
  end
  
end
