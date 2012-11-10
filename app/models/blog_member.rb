# -*- coding: utf-8 -*-
# +-----------------+--------------+------+-----+---------+----------------+
# | Field           | Type         | Null | Key | Default | Extra          |
# +-----------------+--------------+------+-----+---------+----------------+
# | id              | int(11)      | NO   | PRI | NULL    | auto_increment |
# | group_member_id | int(11)      | YES  |     | NULL    |                |
# | group_id        | int(11)      | YES  |     | NULL    |                |
# | blog_url        | varchar(255) | YES  |     | NULL    |                |
# | blog_name       | varchar(50)  | YES  |     | NULL    |                |
# | description     | text         | YES  |     | NULL    |                |
# | created_at      | datetime     | NO   |     | NULL    |                |
# | updated_at      | datetime     | NO   |     | NULL    |                |
# +-----------------+--------------+------+-----+---------+----------------+
class BlogMember < ActiveRecord::Base
  attr_accessible :blog_name, :blog_url, :description, :group_member_id, :group_id
  
  #アソシエーションの定義
  belongs_to :group
  has_one :group_member
  has_many :blog_updates

end
