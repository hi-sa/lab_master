class FbMember < ActiveRecord::Base

  attr_accessible :group_member_id,:group_id,:fb_id,:fb_name,:gender,:image_url

  # アソシエーション
  belongs_to :group_member
  has_many :fbu_base_posts
  has_many :fb_posts


end
