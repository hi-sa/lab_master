class FbUser < ActiveRecord::Base
  attr_accessible :email, :expires_at, :expires_at_to_dt, :fb_id, :fb_name, :image, :name, :token

  #ユーザーの新規登録処理
  def self.create_fbaccount(auth)
    fbuser = FbUser.new
    fbuser.fb_id = auth['uid'] 
    fbuser.fb_name = auth['info']['nickname'] #154423523
    fbuser.email = auth['info']['email'] #http://a0.twimg.com/profile_....
    fbuser.name = auth['info']['name'] #もぐらさん
    fbuser.image = auth['info']['image'] #http://a0.twimg.com/profile_....
    fbuser.token = auth['credentials']['token'] #アクセストークン
    unixtime = auth['credentials']['expires_at']
    fbuser.expires_at = unixtime 
    fbuser.expires_at_to_dt = Time.at(unixtime)
    fbuser.save!
  end

end
