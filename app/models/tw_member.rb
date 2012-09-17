class TwMember < ActiveRecord::Base
  attr_accessible :description, :group_member_id, :image_url, :name, :screen_name, :twitter_id, :group_id
  
  #アソシエーションの定義
  belongs_to :group
  has_one :group_member, foreign_key: :group_member_id
  has_many :tweets

end
