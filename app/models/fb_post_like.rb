# -*- coding: utf-8 -*-
# +------------+-------------+------+-----+---------+----------------+
# | Field      | Type        | Null | Key | Default | Extra          |
# +------------+-------------+------+-----+---------+----------------+
# | id         | int(11)     | NO   | PRI | NULL    | auto_increment |
# | fb_post_id | int(11)     | YES  |     | NULL    |                |
# | post_id    | varchar(50) | YES  |     | NULL    |                |
# | fb_id      | bigint(20)  | YES  |     | NULL    |                |
# | created_at | datetime    | NO   |     | NULL    |                |
# | updated_at | datetime    | NO   |     | NULL    |                |
# +------------+-------------+------+-----+---------+----------------+
class FbPostLike < ActiveRecord::Base
  attr_accessible :id, :fb_post_id, :post_id, :fb_id

  belongs_to :fb_post

  def get_image
    FbGroupMember.find_by_fb_id(self.fb_id).image_url
  end

  # コメント数ランキング
  def self.listup_like_users(group_id)
    if FbGroup.is_group_id?(group_id)
      sql ="SELECT fm.fb_id,COUNT(fpl.post_id) as counter,fm.fb_name,fm.image_url 
            FROM fb_post_likes fpl 
            INNER JOIN fb_posts fp USING(post_id) 
            INNER JOIN fb_members fm ON fpl.fb_id = fm.fb_id 
            WHERE fp.group_id = ? 
            GROUP BY fpl.fb_id 
            ORDER BY counter DESC;";
      like_users = self.find_by_sql([sql,group_id])
    else
      sql ="SELECT fm.fb_id,COUNT(fpl.post_id) as counter,fm.fb_name,fm.image_url 
            FROM fb_post_likes fpl 
            INNER JOIN fb_posts fp USING(post_id) 
            INNER JOIN fb_members fm ON fpl.fb_id = fm.fb_id 
            GROUP BY fpl.fb_id 
            ORDER BY counter DESC;";
      like_users = self.find_by_sql(sql)
    end
  end

  def self.count_likes_num(group_id)
    if FbGroup.is_group_id?(group_id)
      like_count = self.joins(:fb_post).where("group_id = #{group_id}").count
    else
      like_count = self.joins(:fb_post).count
    end
  end

  def self.count_this_month_likes_num(group_id)
    t_month = Date.new(Date.today.year, Date.today.mon, 1)
    t_month = t_month.strftime('%Y%m')
    if FbGroup.is_group_id?(group_id)
      like_count = self.joins(:fb_post).where("group_id = #{group_id}").where("DATE_FORMAT(created_time, '%Y%m') = #{t_month}").count
    else
      like_count = self.joins(:fb_post).where("DATE_FORMAT(created_time, '%Y%m%d') = #{t_month}").count
    end
  end

  def self.count_last_month_likes_num(group_id)
    l_month = Date.new(Date.today.year, Date.today.mon-1, 1)
    l_month = l_month.strftime('%Y%m')
    if FbGroup.is_group_id?(group_id)
      comment_count = self.joins(:fb_post).where("group_id = #{group_id}").where("DATE_FORMAT(created_time, '%Y%m') = #{l_month}").count
    else
      comment_count = self.joins(:fb_post).where("DATE_FORMAT(created_time, '%Y%m%d') = #{l_month}").count
    end
  end
 


 
  
end
