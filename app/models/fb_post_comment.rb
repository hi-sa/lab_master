class FbPostComment < ActiveRecord::Base
  # attr_accessible :title, :body
  
  belongs_to :fb_post

  def get_image
    FbGroupMember.find_by_fb_id(self.fb_id).image_url
  end

end
