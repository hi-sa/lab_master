# -*- coding: utf-8 -*-
# +------------+---------------------+------+-----+---------+----------------+
# | Field      | Type                | Null | Key | Default | Extra          |
# +------------+---------------------+------+-----+---------+----------------+
# | id         | int(11)             | NO   | PRI | NULL    | auto_increment |
# | user_id    | int(10) unsigned    | YES  |     | NULL    |                |
# | group_id   | bigint(20) unsigned | YES  | UNI | NULL    |                |
# | name       | varchar(30)         | YES  |     | NULL    |                |
# | icon       | varchar(150)        | YES  |     | NULL    |                |
# | created_at | datetime            | NO   |     | NULL    |                |
# | updated_at | datetime            | NO   |     | NULL    |                |
# +------------+---------------------+------+-----+---------+----------------+
class FbGroup < ActiveRecord::Base
  attr_accessible :user_id, :group_id, :name, :icon, :id

  # アソシエーション
  has_many :fb_group_members

  # 全てのグループIDを配列にして返す
  def self.get_all_group_id
    all_group_id = Array.new
    self.all.each do |group|
      all_group_id << group.group_id
    end
    return all_group_id
  end

  # 存在するグループIDか否か
  def self.is_group_id?(group_id)
    all_group_id = self.get_all_group_id
    return all_group_id.include?(group_id.to_i) #to_iにしないと、結果が全てfalseになってしまう
  end
  
end
