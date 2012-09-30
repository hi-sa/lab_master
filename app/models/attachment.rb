# -*- coding: utf-8 -*-
class Attachment < ActiveRecord::Base
  attr_accessible :id, :mail_id, :file_id, :filename, :ext, :mime_type 

  # アソシエーション
  belongs_to :mail

  # Kaminari(ページネーション)の設定。1ページに表示する件数
  paginates_per 20

  # 条件(パラメータ）を元にファイルの検索をし、取得する
  def self.search_files_with_params(opt)
    # パラメータに日付指定がある場合
    if opt['date']
      files = self.search_files_by_date(opt['date'], opt['sort'])
    # パラメータに検索クエリがある場合
    elsif opt['query']
      files = self.search_files_by_query(opt['query'], opt['sort'])
    # パラメータに送信者指定がある場合
    elsif opt['sender']
      files = self.search_files_by_sender(opt['sender'], opt['sort'])
    # 上記のいずれのパラメータ指定もない場合
    else
      files = self.search_files(opt['sort'])
    end

    return files
  end

  # 日付検索
  def self.search_files_by_date(date, sort)
    if sort == 'asc'
      files = self.joins(:mail).where("DATE_FORMAT(send_at,'%Y%m') = #{date}").order('send_at ASC').limit(30)
    else
      files = self.joins(:mail).where("DATE_FORMAT(send_at,'%Y%m') = #{date}").order('send_at DESC').limit(30)
    end

    return files
  end

  # キーワード検索
  def self.search_files_by_query(query, sort)
    if sort == 'asc'
      files = self.joins(:mail).where('body LIKE ? or subject LIKE ? or sender LIKE ?', "%#{query}%", "%#{query}%", "%#{query}%").order('send_at ASC').limit(30)
    else
      files = self.joins(:mail).where('body LIKE ? or subject LIKE ? or sender LIKE ?', "%#{query}%", "%#{query}%", "%#{query}%").order('send_at DESC').limit(30)
    end

    return files
  end

  # 送信者検索
  def self.search_files_by_sender(sender, sort)
    if sort == 'asc'
      files = self.joins(:mail).where('sender LIKE ?', "%#{sender}%").order("send_at ASC").limit(30)
    else
      files = self.joins(:mail).where('sender LIKE ?', "%#{sender}%").order("send_at DESC").limit(30)
    end

    return files
  end

  def self.search_files(sort)
    if sort == 'asc'
      files = self.joins(:mail).order("send_at ASC").limit(30)
    else
      files = self.joins(:mail).order("send_at DESC").limit(30)
    end

    return files
  end

  # 表示中のファイルの件数を取得する
  def self.count_showed_files(search_options)
    if search_options['date']
      date = search_options['date']
      showed_files = self.joins(:mail).where("DATE_FORMAT(send_at,'%Y%m') = #{date}").count
    elsif search_options['query']
      query = search_options['query']
      showed_files = self.joins(:mail).where('body LIKE ? or subject LIKE ? or sender LIKE ?', "%#{query}%", "%#{query}%", "%#{query}%").count
    elsif search_options['sender']
      sender = search_options['sender']
      showed_files = self.joins(:mail).where('sender LIKE ?', "%#{sender}%").count
    else
      showed_files = self.joins(:mail).count_all_files
    end

    return showed_files
  end

  # 日付(年-月)毎の件数を取得する
  def self.search_by_send_at
    self.joins(:mail).
         select("DATE_FORMAT(mails.send_at,'%Y年%m月') as 'year_month', COUNT(attachments.id) as num, DATE_FORMAT(mails.send_at, '%Y%m') as 'query_value'").
         group("DATE_FORMAT(mails.send_at,'%Y年%m月') DESC")
  end

  # ファイルを拡張子ごとに集計する
  def self.count_ext_num
    self.select('ext, COUNT(ext) as num').group('ext')
  end

  # 全ファイルの数を取得
  def self.count_all_files
    self.count
  end

  # 送信者のメールアドレスの取得
  def self.search_sender_mail_addresses
    self.joins(:mail).select('mails.sender').group('mails.sender').order('COUNT(mails.sender) DESC')
  end

end
