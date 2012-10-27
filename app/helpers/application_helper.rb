# -*- coding: utf-8 -*-
module ApplicationHelper

  require 'nokogiri'
  require 'open-uri'

  #def current_user
  #  @current_user ||= User.find(session[:user_id]) if session[:user_id]
  #end

  def hbr(str)
    str = html_escape(str)
    str.gsub(/\r\n|\r|\n/, "<br />")
  end

  # URLからウェブページのタイトルを取得する
  def get_title_from_html(url)
    begin
      html = Nokogiri::HTML(open(url))

      # titleタグの抽出
      title = html.css('title').inner_html
    rescue
      title = "タイトルの取得に失敗"
    end

    return title.encode('UTF-8')
  end

  def convert_minute_to_hour(minute)
    if minute > 60
      hour = minute / 60
      minute = minute % 60
      time = "#{hour}時間#{minute}分"
    elsif minute == 60
      hour = 1
      time = "#{hour}時間"
    else 
      time = "#{minute}分"
    end
    return time
  end


end
