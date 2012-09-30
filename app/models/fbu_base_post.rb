# -*- coding: utf-8 -*-
class FbuBasePost < ActiveRecord::Base
  attr_accessible :id, :fb_member_id, :post_id, :fb_id, :type, :created_time, :updated_time

  belongs_to :fb_member
  has_one :fbu_post_link
  has_one :fbu_post_picture
  has_one :fbu_post_status
  has_one :fbu_post_video
  has_many :fbu_post_comments
  has_many :fbu_post_likes


  # mainグループから最新のポストをそれぞれ[hoge]件ずつ取得
  def self.main_group_feeds
    # フィードを格納する配列の生成
    feeds = Array.new
    # メンバーIDを格納する配列の生成
    member_ids = Array.new

    # メイングループのGroupオブジェクトの取得
    main_groups = Group.main_groups

    main_groups.each do |group|
      # グループメンバーのIDを配列にまとめる
      group.group_members.each do |member|
        member_ids << member.id
      end

      # 最新[hoge]件のpostを取得
      feeds << self.where(:fb_member_id => member_ids).order('created_time DESC').limit(30)
      #feeds << self.where(:fb_member_id => member_ids, :post_type => ['video']).order('created_time DESC').limit(30)

      member_ids = []
    end

    return feeds

  end




end
