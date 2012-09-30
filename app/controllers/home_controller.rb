# -*- coding: utf-8 -*-
class HomeController < ApplicationController

  skip_filter :check_logined, only: [:index]

  # このアクションはログイン画面とホーム画面を兼ねている
  def index
    # ログイン状態でビューの描画を切り分ける
    if session[:user_id]
      #@user = User.find(session[:user_id])
      render 'index'
    else
      render 'login'
    end
  end

  def pdf
    send_file("public/ozaken/f_1300778637_1.pdf")
  end

end
