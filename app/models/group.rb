# -*- coding: utf-8 -*-
# +-------------+-------------+------+-----+---------+----------------+
# | Field       | Type        | Null | Key | Default | Extra          |
# +-------------+-------------+------+-----+---------+----------------+
# | id          | int(11)     | NO   | PRI | NULL    | auto_increment |
# | user_id     | int(11)     | YES  |     | NULL    |                |
# | name        | varchar(30) | YES  |     | NULL    |                |
# | description | text        | YES  |     | NULL    |                |
# | main_flg    | tinyint(1)  | YES  |     | NULL    |                |
# | created_at  | datetime    | NO   |     | NULL    |                |
# | updated_at  | datetime    | NO   |     | NULL    |                |
# +-------------+-------------+------+-----+---------+----------------+

class Group < ActiveRecord::Base
  attr_accessible :name, :description, :main_flg, :user_id, :id
  
  #アソシエーションの定義
  belongs_to :user
  has_many :group_members
  #has_and_belongs_to_many :group_members


  # main_groupsの取得
  def self.main_groups
    main_groups = self.find_all_by_main_flg(true)
  end

  # main_groupかどうか
  def main_group?
    self.main_flg == true
  end

  # 全てのグループIDを配列にして返す
  def self.get_all_group_id
    all_group_id = Array.new
    self.all.each do |group|
      all_group_id << group.id
    end
    return all_group_id
  end

  # 存在するグループIDか否か
  def self.is_group_id?(group_id)
    all_group_id = self.get_all_group_id
    return all_group_id.include?(group_id.to_i) #to_iにしないと、結果が全てfalseになってしまう
  end

end
