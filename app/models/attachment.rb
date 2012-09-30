# -*- coding: utf-8 -*-
class Attachment < ActiveRecord::Base
  attr_accessible :id, :mail_id, :file_id, :filename, :ext, :mime_type 

  belongs_to :mail

  # 降順でファイルを取得 
  def self.search_recent_attachments
    #self.order('id DESC').limit(30)
    self.joins('INNER JOIN mails ON attachments.mail_id = mails.id').
         select('mails.send_at, mails.sender, attachments.*').
         order('mails.send_at DESC').
         limit(30)
  end

  # 日付(年-月)毎の件数を取得する
  def self.search_by_send_at
    self.joins('INNER JOIN mails ON attachments.mail_id = mails.id').
         select("DATE_FORMAT(mails.send_at,'%Y年%m月') as 'year_month', COUNT(attachments.id) as num, DATE_FORMAT(mails.send_at, '%Y%m') as 'query_value'").
         group("DATE_FORMAT(mails.send_at,'%Y年%m月') DESC")
  end

  # ファイルを拡張子ごとに集計する
  def self.count_ext_num
    self.select('ext, COUNT(ext) as num').group('ext')
  end

  def self.count_files
    self.count
  end
end
