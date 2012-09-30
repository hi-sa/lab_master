# -*- coding: utf-8 -*-
class SessionsController < ApplicationController

  skip_filter :check_logined

  def callback #login

    #認証後のハッシュ値を受け取る
    auth = request.env['omniauth.auth']

    #ユーザーが既に登録されているかをチェックする
    user = User.find_by_twitter_id("#{auth['uid']}")

    if user 
      #既にUsersテーブルに登録されている場合
      session[:user_id] = user.id
      session[:twitter_id] = user.twitter_id
      redirect_to root_url
    else 
      #登録されていない場合はユーザー情報のDB登録
      User.create_account(auth)

      #ユーザー情報をセッションへ格納
      user = User.find_by_twitter_id("#{auth['uid']}")
      session[:user_id] = user.id
      session[:twitter_id] = user.twitter_id

      #ルートにリダイレクト
      redirect_to root_url 
    end
  end


  def destroy #logout
    #セッションを開放する
    reset_session

    #ログイン画面にリダイレクトする
    redirect_to root_url
  end


  def fb_callback

    auth = request.env['omniauth.auth']
    # OauthToken取得
    logger.debug(auth)

    user = FbUser.find_by_fb_id("#{auth['uid']}")

    if user 
      session[:fb_id] = user.fb_id
      session[:fbuser_id] = user.id
      redirect_to root_url
    else 
      FbUser.create_fbaccount(auth)
      user = FbUser.find_by_fb_id("#{auth['uid']}")
      session[:fb_id] = user.fb_id
      session[:fbuser_id] = user.id
      redirect_to root_url
    end

  end


  def fb_destroy
    reset_session
    redirect_to root_url, :notice=> "sign out"
  end

end
