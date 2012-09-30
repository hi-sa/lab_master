class FacebookController < ApplicationController

  # ---
  # とりあえず、twitterのレイアウトを利用する
  # twitterのレイアウトを「tw_fb.html.erb」のように変更するか、それともアプリ全体に共通のapplication.thml.erbのほうにするか
  # はたまた、twitter.html.erb、facebook.html.erbのように分けるか開発を進めながら検討する
  # ---
  # レイアウトの選択
  layout "twitter"

  def index

    # メイングループの取得
    @main_groups = Group.main_groups

    # メイングループの最新10件のポストを取得(group数は3にしておく)
    @feeds = FbuBasePost.main_group_feeds

  end


  def show
  end

  def group
    @posts = FbPost.recent_posts(params[:group_id]) 
  end

end

