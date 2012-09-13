class GroupMember < ActiveRecord::Base
  attr_accessible :blog_url, :fb_id, :group_id, :twitter_id, :name, :image_url

  #アソシエーションの定義
  belongs_to :tw_member
  belongs_to :fb_member
  belongs_to :blog_member
  belongs_to :group
  #has_and_belongs_to_many :groups
  
end
