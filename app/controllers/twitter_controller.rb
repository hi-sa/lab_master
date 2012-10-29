# -*- coding: utf-8 -*-
class TwitterController < ApplicationController

  def index
    # メイングループの取得
    @main_groups = Group.main_groups

    # メイングループの最新[hoge]件のツイートを取得(group数は3にしておく)
    @tweets = Tweet.main_group_tweets

  end

  def show 
    # URLパラメータ一覧
    # params[:id] グループID 
    # params[:d] 全てorハッシュタグ付きorURL付き 
    # params[:u] ユーザー 
    # params[:q] クエリ検索 
    # params[:dt] 日付

    # 存在するグループか否か。存在しない場合はall
    params[:id] = 'all' unless Group.is_group_id?(params[:id])
    params[:d] = 'all' unless params[:d]
    search_options = params

    # メイングループの取得
    @main_groups = Group.main_groups

    # メンバー名の取得
    @group_members = TwMember.get_members(params[:id])

    # ツイート情報の取得
    tweets = Tweet.select_tweets(params)
    @tweets = Kaminari.paginate_array(tweets[:tweets]).page(params[:page]).per(30)
    @group_name = tweets[:group_name]

    # ツイート数ランキング
    @rank_tweets = Tweet.rank_tweets_count(params[:id])

    # 全ツイート数
    @sum_tweets = Tweet.sum_tweets(params[:id])

    # 利用クライアントランキング
    @rank_client = Tweet.rank_client_ratio(params[:id])

    # URLを含むツイートの取得
    @url_tweets = UrlTweet.get_recent_tweets(params[:id])

    # ハッシュタグの取得
    @hashtags = Hashtag.extract_hashtag(params[:id])

    # ツイートの時間帯の分布
    @tweet_time = Tweet.plot_tweet_time(params[:id])

    # 最後にツイートした時間からの経過時間(分)
    @transmit_time = Tweet.calc_transmit_time(params[:id])

    # 平均ツイート数(グループ単位、グループのメンバー単位)
    @avg_tweets = Tweet.calc_avg_tweet(params[:id])
    # 平均ツイート数(全グループ)
    @avg_tweets_in_all_groups = Tweet.calc_avg_tweet_in_all_groups(params[:id]) if Group.is_group_id?(params[:id])
  end

end
