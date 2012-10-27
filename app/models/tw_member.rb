# -*- coding: utf-8 -*-
# +-----------------+--------------+------+-----+---------+----------------+
# | Field           | Type         | Null | Key | Default | Extra          |
# +-----------------+--------------+------+-----+---------+----------------+
# | id              | int(11)      | NO   | PRI | NULL    | auto_increment |
# | group_member_id | int(11)      | YES  | UNI | NULL    |                |
# | group_id        | int(11)      | YES  |     | NULL    |                |
# | twitter_id      | int(11)      | YES  | UNI | NULL    |                |
# | name            | varchar(50)  | YES  |     | NULL    |                |
# | screen_name     | varchar(15)  | YES  |     | NULL    |                |
# | image_url       | varchar(255) | YES  |     | NULL    |                |
# | description     | text         | YES  |     | NULL    |                |
# | created_at      | datetime     | NO   |     | NULL    |                |
# | updated_at      | datetime     | NO   |     | NULL    |                |
# +-----------------+--------------+------+-----+---------+----------------+
class TwMember < ActiveRecord::Base
  attr_accessible :description, :group_member_id, :image_url, :name, :screen_name, :twitter_id, :group_id
  
  #アソシエーションの定義
  belongs_to :group
  has_one :group_member, foreign_key: :group_member_id
  has_many :tweets


  def self.make_member_id_array(group_id)
    tw_members = TwMember.where(:group_id => group_id)

    tw_id_array = Array.new

    tw_members.each do |tw_member|
      tw_id_array << tw_member.twitter_id
    end

    return tw_id_array

  end

end
