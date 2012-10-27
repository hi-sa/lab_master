# -*- coding: utf-8 -*-
class TwitterController < ApplicationController

  def index
    # メイングループの取得
    @main_groups = Group.main_groups

    # メイングループの最新[hoge]件のツイートを取得(group数は3にしておく)
    @tweets = Tweet.main_group_tweets

    # JOINをして一発で取得するか,アソシエーションを使って取得するかで悩み中（取得ツイート数にもよると思うが、ひとまずはJOINの利用をする）
    #@tweets_2nd = Tweet.where(:twitter_id => tw_id_2nd).order('tweet_at DESC').limit(100)
    # 2期生のツイート
    #tw_id_2nd = GroupMember.array_twitter_ids(1)
    #@tweets_2nd = Tweet.where(:twitter_id => tw_id_2nd).joins('INNER JOIN tw_members USING(twitter_id)')
    #              .select('tweets.*,tw_members.*').order('tweet_at DESC').limit(50)
    # 3期生のツイート
    #tw_id_3rd = GroupMember.array_twitter_ids(2)
    #@tweets_3rd = Tweet.where(:twitter_id => tw_id_3rd).joins('INNER JOIN tw_members USING(twitter_id)')
    #              .select('tweets.*,tw_members.*').order('tweet_at DESC').limit(50)
    # eスクール生、コーチ陣のツイート
    #tw_id_es = GroupMember.array_twitter_ids(3)
    #@tweets_es = Tweet.where(:twitter_id => tw_id_es).joins('INNER JOIN tw_members USING(twitter_id)')
    #             .select('tweets.*,tw_members.*').order('tweet_at DESC').limit(50)

  end

  def show 

    # 存在するグループか否か
    #redirect_to root_path unless Group.is_group_id?(params[:id])
    params[:id] = "all" unless Group.is_group_id?(params[:id])

    # メイングループの取得
    @main_groups = Group.main_groups

    # ツイート情報の取得
    @tweets = Tweet.select_tweets(params[:id])

    # ツイート数ランキング
    @rank_tweets = Tweet.rank_tweets_count(params[:id])

    # 全ツイート数
    @sum_tweets = Tweet.sum_tweets(params[:id])

    # 利用クライアントランキング
    @rank_client = Tweet.rank_client_ratio(params[:id])

    # 平均ツイート数(グループ単位、グループのメンバー単位)
    @avg_tweets = Tweet.calc_avg_tweet(params[:id])

    # 平均ツイート数(全グループ)
    @avg_tweets_in_all_groups = Tweet.calc_avg_tweet_in_all_groups(params[:id]) if Group.is_group_id?(params[:id])

    # URLを含むツイートの取得
    @url_tweets = UrlTweet.get_recent_tweets(params[:id])

    # ハッシュタグの取得
    @hashtags = Hashtag.extract_hashtag(params[:id])

    # ツイートの時間帯の分布
    @tweet_time = Tweet.plot_tweet_time(params[:id])

    # 最後にツイートした時間からの経過時間(分)
    @transmit_time = Tweet.calc_transmit_time(params[:id])
  end

end
