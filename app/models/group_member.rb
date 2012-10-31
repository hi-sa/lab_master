# -*- coding: utf-8 -*-
class GroupMember < ActiveRecord::Base
  attr_accessible :blog_url, :fb_id, :group_id, :twitter_id, :name, :image_url

  #アソシエーションの定義
  belongs_to :tw_member
  belongs_to :fb_member
  belongs_to :blog_member
  belongs_to :group

  # 指定されたグループに所属するメンバーのtwitter_idを配列で返す
  def self.array_twitter_ids(group_id)
    id_array = Array.new
    
    group_members = self.find_all_by_group_id(group_id)
    group_members.each do |member|
      id_array << member.twitter_id
    end
    return id_array
  end

  # ozakenメンバーのtwitteridを配列にして渡す
  def self.make_ozaken_members2array
    ozakens = Array.new
    members = GroupMember.select(:twitter_id).all
    members.each do |member|
      ozakens << member.twitter_id
    end
    return ozakens
  end
  
end
