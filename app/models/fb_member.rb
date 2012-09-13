class FbMember < ActiveRecord::Base
  attr_accessible :group_member_id,:group_id,:fb_id,:fb_name,:gender,:image_url
end
