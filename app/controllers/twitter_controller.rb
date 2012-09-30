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
    #render :text => params[:id]
    
    if params[:id] == ALL
      render :text => "All Group"
    else
      render :text => "One Group"
    end

  end

end
