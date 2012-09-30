class FbGroup < ActiveRecord::Base
  attr_accessible :user_id, :group_id, :name, :icon, :id

  # アソシエーション
  has_mane :fb_group_members

end
