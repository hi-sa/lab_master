# -*- coding: utf-8 -*-
# +--------------+-------------+------+-----+---------+----------------+
# | Field        | Type        | Null | Key | Default | Extra          |
# +--------------+-------------+------+-----+---------+----------------+
# | id           | int(11)     | NO   | PRI | NULL    | auto_increment |
# | fb_post_id   | int(11)     | YES  |     | NULL    |                |
# | post_id      | varchar(50) | YES  |     | NULL    |                |
# | comment_id   | varchar(60) | YES  |     | NULL    |                |
# | fb_id        | bigint(20)  | YES  |     | NULL    |                |
# | message      | text        | YES  |     | NULL    |                |
# | created_time | varchar(30) | YES  |     | NULL    |                |
# | created_at   | datetime    | NO   |     | NULL    |                |
# | updated_at   | datetime    | NO   |     | NULL    |                |
# +--------------+-------------+------+-----+---------+----------------+
class FbPostComment < ActiveRecord::Base
  # attr_accessible :title, :body
  
  belongs_to :fb_post

  def get_image
    FbGroupMember.find_by_fb_id(self.fb_id).image_url
  end

  # コメント数ランキング
  def self.listup_comment_users(group_id)
    if FbGroup.is_group_id?(group_id)
      sql ="SELECT fm.fb_id,COUNT(fpc.post_id) as counter,fm.fb_name,fm.image_url 
            FROM fb_post_comments fpc 
            INNER JOIN fb_posts fp USING(post_id) 
            INNER JOIN fb_members fm ON fpc.fb_id = fm.fb_id 
            WHERE fp.group_id = ? 
            GROUP BY fpc.fb_id 
            ORDER BY counter DESC;";
      comment_users = self.find_by_sql([sql,group_id])
    else
      sql ="SELECT fm.fb_id,COUNT(fpc.post_id) as counter,fm.fb_name,fm.image_url 
            FROM fb_post_comments fpc 
            INNER JOIN fb_posts fp USING(post_id) 
            INNER JOIN fb_members fm ON fpc.fb_id = fm.fb_id 
            GROUP BY fpc.fb_id 
            ORDER BY counter DESC;";
      comment_users = self.find_by_sql(sql)
    end
  end

  def self.count_comments_num(group_id)
    if FbGroup.is_group_id?(group_id)
      comment_count = self.joins(:fb_post).where("group_id = #{group_id}").count
    else
      comment_count = self.joins(:fb_post).count
    end
  end

  def self.count_this_month_comments_num(group_id)
    t_month = Date.new(Date.today.year, Date.today.mon, 1)
    t_month = t_month.strftime('%Y%m')
    if FbGroup.is_group_id?(group_id)
      comment_count = self.joins(:fb_post).where("group_id = #{group_id}").where("DATE_FORMAT(fb_post_comments.created_time, '%Y%m') = #{t_month}").count
    else
      comment_count = self.joins(:fb_post).where("DATE_FORMAT(fb_post_comments.created_time, '%Y%m%d') = #{t_month}").count
    end
  end

  def self.count_last_month_comments_num(group_id)
    l_month = Date.new(Date.today.year, Date.today.mon-1, 1)
    l_month = l_month.strftime('%Y%m')
    if FbGroup.is_group_id?(group_id)
      comment_count = self.joins(:fb_post).where("group_id = #{group_id}").where("DATE_FORMAT(fb_post_comments.created_time, '%Y%m') = #{l_month}").count
    else
      comment_count = self.joins(:fb_post).where("DATE_FORMAT(fb_post_comments.created_time, '%Y%m%d') = #{l_month}").count
    end
  end

end
