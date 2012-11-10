# -*- coding: utf-8 -*-
# +------------+--------------+------+-----+---------+----------------+
# | Field      | Type         | Null | Key | Default | Extra          |
# +------------+--------------+------+-----+---------+----------------+
# | id         | int(11)      | NO   | PRI | NULL    | auto_increment |
# | twitter_id | int(11)      | YES  |     | NULL    |                |
# | title      | varchar(255) | YES  |     | NULL    |                |
# | url        | varchar(200) | YES  |     | NULL    |                |
# | feed_url   | varchar(255) | YES  |     | NULL    |                |
# | crawl_flg  | tinyint(1)   | YES  |     | NULL    |                |
# | created_at | datetime     | NO   |     | NULL    |                |
# | updated_at | datetime     | NO   |     | NULL    |                |
# +------------+--------------+------+-----+---------+----------------+
class RegisteredBlog < ActiveRecord::Base
  attr_accessible :twitter_id, :title, :url, :feed_url, :crawl_flg

  has_many :blogs
end
