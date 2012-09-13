class BlogMember < ActiveRecord::Base
  attr_accessible :blog_name, :blog_url, :description, :group_member_id
  
  #アソシエーションの定義
  belongs_to :group
  has_one :group_member
  has_many :blog_updates

end
