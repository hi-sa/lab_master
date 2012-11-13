# -*- coding: utf-8 -*-
class BlogController < ApplicationController
  layout "twitter"
  before_filter :is_admin, :only => ['new','create','edit','update','destroy']

  def index
    # URLパラメータの取得
    search_options = params
    @blogs = Blog.search_entry_with_params(search_options).page params[:page]
    #@blogs = Blog.order('posted_at DESC').limit(30).page params[:page]

    # 日付
    @entry_date = Blog.list_up_blog_entry_by_date

    # RSS登録されているブログ 
    @registered_blogs = RegisteredBlog.all
  end

  def new
    @blog = RegisteredBlog.new
    @registered_blogs = RegisteredBlog.all
  end

  def create
    @blog = RegisteredBlog.new
    @blog.title = params[:registered_blog][:title]
    @blog.url = params[:registered_blog][:url]
    @blog.feed_url = params[:registered_blog][:feed_url]
    @blog.twitter_id = session[:twitter_id]
    @blog.crawl_flg = true 

    if @blog.save
      redirect_to(new_blog_path, alert: "新しいブログの登録が完了しました！")
    else
      redirect_to(new_blog_path.errors, status: "unprocessable_entity")
    end
  end

  def edit
    @blog = RegisteredBlog.find(params[:id])
    @registered_blogs = RegisteredBlog.all
  end

  def update
    @blog = RegisteredBlog.find(params[:id])
    if @blog.update_attributes(params[:registered_blog])
      redirect_to edit_blog_path(params[:id], alert: "ブログの編集が完了しました！")
    else
      redirect_to edit_blog_path(params[:id], alert: "ブログの編集に失敗しました。もう一度やり直してください。")
    end
  end

  def destroy
    @blog = RegisteredBlog.find(params[:id])
    @blog.destroy

    redirect_to blog_index_path
  end

  private

  def is_admin
    unless session[:twitter_id] == 154423524
      redirect_to blog_index_path
    end
  end

end
