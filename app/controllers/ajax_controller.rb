# -*- coding: utf-8 -*-
class AjaxController < ApplicationController

  def search_website
    @url = params[:url]

    begin
      agent = Mechanize.new
      agent.get(@url)
      @title = agent.page.title.toutf8
    rescue
      @title = "" 
    end 

    @feed_url = `cd /var/work; php findfeedurl.php #{@url}`
    
    @error = '該当するアイテムは見つかりませんでした' if @title == ''
  end

end
