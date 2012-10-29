# -*- coding: utf-8 -*-
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
    # 存在するグループか否か。存在しない場合はall
    params[:id] = 'all' unless FbGroup.is_group_id?(params[:group_id])
    params[:d] = 'all' unless params[:d]
    search_options = params

    # 投稿の取得
    #@posts = FbPost.recent_posts(params[:group_id]).page(params[:page])
    @posts = FbPost.select_posts(params).page params[:page]

    # グループ名
    @group_name = FbGroup.find_by_group_id(params[:group_id])

    # 投稿ユーザーの取得(横棒のグラフ）
    @post_users_ranking = FbPost.listup_post_users(params[:group_id])
    # 全ての投稿数
    @post_num = FbPost.count_posts_num(params[:group_id])
    # 今月の投稿数
    @this_month_post_num = FbPost.count_this_month_posts_num(params[:group_id])
    # 先月の投稿数
    @last_month_post_num = FbPost.count_last_month_posts_num(params[:group_id])

    # コメントユーザーの降順取得
    @comment_users_ranking = FbPostComment.listup_comment_users(params[:group_id])
    # 全てのコメント数
    @comment_num = FbPostComment.count_comments_num(params[:group_id])
    # 今月のコメント数
    @this_month_comment_num = FbPostComment.count_this_month_comments_num(params[:group_id])
    # 先月のコメント数
    @last_month_comment_num = FbPostComment.count_last_month_comments_num(params[:group_id])

    # いいねユーザーの降順取得
    @like_users_ranking = FbPostLike.listup_like_users(params[:group_id])
    # 全てのコメント数
    @like_num = FbPostLike.count_likes_num(params[:group_id])
    # 今月のコメント数
    @this_month_like_num = FbPostLike.count_this_month_likes_num(params[:group_id])
    # 先月のコメント数
    @last_month_like_num = FbPostLike.count_last_month_likes_num(params[:group_id])

    # グループの写真
    @group_pictures = FbPostPicture.select_pictures(params[:group_id])

    # グループメンバーの情報
    @group_members_info = FbGroupMember.select_group_members_info(params[:group_id])
  end

end

