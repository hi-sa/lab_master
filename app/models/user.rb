# -*- coding: utf-8 -*-
class User < ActiveRecord::Base
  attr_accessible :access_token, :access_token_secret, :image_url, :location, :name, :screen_name, :twitter_id, :id, :description
  
  #アソシエーションの定義
  has_many :groups


  #ユーザーの新規登録処理
  def self.create_account(auth)
    user = User.new
    user.twitter_id = auth['uid'] #154423523
    user.name = auth['info']['name'] #もぐらさん
    user.screen_name = auth['info']['nickname'] #mogulla3
    user.image_url = auth['info']['image'] #http://a0.twimg.com/profile_....
    user.description = auth['info']['description'] #早稲田大学人間科学部....
    user.access_token = auth['credentials']['token'] #アクセストークン
    user.access_token_secret = auth['credentials']['secret'] #アクセストークンシークレット
    user.save!
  end


end
