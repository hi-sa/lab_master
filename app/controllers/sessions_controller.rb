class SessionsController < ApplicationController

  def callback #login
    #認証後のハッシュ値を受け取る
    auth = request.env['omniauth.auth']

    #ユーザーが既に登録されているかをチェックする
    #userの中には、usersテーブルのレコードが一式格納されている →　Userオブジェクトという
    user = User.find_by_twitter_id("#{auth['uid']}")

    if user 
      #既にUsersテーブルに登録されている場合
      session[:twitter_id] = user.twitter_id
      session[:user_id] = user.id
      redirect_to root_url, :notice=>"Login OK!"
    else 
      #登録されていない場合
      #ユーザー情報のDB登録
      User.create_account(auth)
  
      #ここで、変数userにユーザー情報格納し、セッション変数にも格納しておかないと挙動がおかしくなる
      user = User.find_by_twitter_id("#{auth['uid']}")
      session[:user_id] = user.id
     
      #ルートにリダイレクト
      redirect_to root_url, :notice=>"#{auth['info']['name']}'s Twitter Account get!"
    end
  end


  def fb_callback
    #認証後のハッシュ値を受け取る
    auth = request.env['omniauth.auth']
    # raise auth.to_yaml
    # exit
    logger.debug(auth)

    #ユーザーが既に登録されているかをチェックする
    user = FbUser.find_by_fb_id("#{auth['uid']}")

    if user 
      #既にUsersテーブルに登録されている場合
      session[:fb_id] = user.fb_id
      session[:fbuser_id] = user.id
      redirect_to root_url, :notice=>"FbLogin OK!"
    else 
      #登録されていない場合 → ユーザー情報のDB登録
      FbUser.create_fbaccount(auth)
  
      #ここで、変数userにユーザー情報格納し、セッション変数にも格納しておかないと挙動がおかしくなる
      user = FbUser.find_by_fb_id("#{auth['uid']}")
      session[:fb_id] = user.fb_id
      session[:fbuser_id] = user.id
     
      #ルートにリダイレクト
      redirect_to root_url, :notice=>"#{auth['info']['name']}'s Facebook Account get!"
    end

  end


  def destroy #logout
    #セッションを開放する
    session[:twitter_id] = nil
    session[:user_id] = nil

    #ログイン画面にリダイレクトする
    redirect_to root_url, :notice=> "sign out"
  end


  def fb_destroy
    #セッションを開放する
    session[:fb_id] = nil
    session[:fbuser_id] = nil

    #ログイン画面にリダイレクトする
    redirect_to root_url, :notice=> "sign out"
  end

end
