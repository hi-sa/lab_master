# -*- coding: utf-8 -*-
# +-------------+---------------------+------+-----+---------+----------------+
# | Field       | Type                | Null | Key | Default | Extra          |
# +-------------+---------------------+------+-----+---------+----------------+
# | id          | int(11)             | NO   | PRI | NULL    | auto_increment |
# | fb_group_id | int(10) unsigned    | YES  |     | NULL    |                |
# | group_id    | bigint(20) unsigned | YES  |     | NULL    |                |
# | fb_id       | bigint(20) unsigned | YES  | UNI | NULL    |                |
# | fb_name     | varchar(50)         | YES  |     | NULL    |                |
# | gender      | varchar(10)         | YES  |     | NULL    |                |
# | image_url   | varchar(120)        | YES  |     | NULL    |                |
# | created_at  | datetime            | NO   |     | NULL    |                |
# | updated_at  | datetime            | NO   |     | NULL    |                |
# +-------------+---------------------+------+-----+---------+----------------+
class FbGroupMember < ActiveRecord::Base
  attr_accessible :group_id, :fb_id, :fb_name, :gender, :image_url, :id

  # アソシエーション
  belongs_to :fb_group
  has_many :fb_posts


  #select count(*) from fb_group_members fgm inner join fb_groups fg on fgm.fb_group_id = fg.id;
  def self.select_group_members_info(group_id)
    if FbGroup.is_group_id?(group_id)
      self.where(:group_id => group_id)
    else
      self.all
    end
  end
  


end
