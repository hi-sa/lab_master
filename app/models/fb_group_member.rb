class FbGroupMember < ActiveRecord::Base
  attr_accessible :group_id, :fb_id, :fb_name, :gender, :image_url, :id

  # アソシエーション
  belongs_to :fb_group
  has_many :fb_posts

end
