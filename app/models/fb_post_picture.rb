# -*- coding: utf-8 -*-
# +------------+--------------+------+-----+---------+----------------+
# | Field      | Type         | Null | Key | Default | Extra          |
# +------------+--------------+------+-----+---------+----------------+
# | id         | int(11)      | NO   | PRI | NULL    | auto_increment |
# | fb_post_id | int(11)      | YES  |     | NULL    |                |
# | post_id    | varchar(50)  | YES  |     | NULL    |                |
# | picture    | varchar(130) | YES  |     | NULL    |                |
# | object_id  | varchar(20)  | YES  |     | NULL    |                |
# | created_at | datetime     | NO   |     | NULL    |                |
# | updated_at | datetime     | NO   |     | NULL    |                |
# +------------+--------------+------+-----+---------+----------------+
class FbPostPicture < ActiveRecord::Base
  attr_accessible :id, :fb_post_id, :post_id, :picture, :object_id

  belongs_to :fb_post

  def self.select_pictures(group_id)
  #select * From fb_post_pictures fpp inner join fb_posts fp using(post_id) where fp.group_id = '226826110680052';
    if FbGroup.is_group_id?(group_id)
      self.joins(:fb_post).where("group_id = #{group_id}")
    else
      self.joins(:fb_post).all
    end
  end




end
