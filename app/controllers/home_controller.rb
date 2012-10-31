# -*- coding: utf-8 -*-
class HomeController < ApplicationController

  skip_filter :check_logined, only: [:index]
  layout "twitter"

  # このアクションはログイン画面とホーム画面を兼ねている
  def index
    # ログイン状態でビューの描画を切り分ける
    if session[:user_id]
      @feeds = FbuBasePost.where("post_type != 'status'").order('created_time desc').limit(30)
      @mails = Mail.order('send_at DESC').limit('10')
      @attachments = Attachment.joins(:mail).order('send_at DESC').limit('10')
      render 'index'
    else
      render 'login'
    end
  end

end
