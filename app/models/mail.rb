# -*- coding: utf-8 -*-
class Mail < ActiveRecord::Base

  attr_accessible :id, :org_id, :subject, :sender, :to, :body, :send_at, :attach_flg 

  # アソシエーション
  has_one :attachment

  # Kaminari(ページネーション)の設定。1ページに表示する件数
  paginates_per 20

  # 条件(パラメータ）を元にメールの検索をし、取得する
  def self.search_mails_with_params(opt)
    # パラメータに日付指定がある場合
    if opt['date']
      mails = self.search_mails_by_date(opt['date'], opt['data'], opt['sort'])
    # パラメータに検索クエリがある場合
    elsif opt['query']
      mails = self.search_mails_by_query(opt['query'], opt['data'], opt['sort'])
    # パラメータに送信者指定がある場合
    elsif opt['sender']
      mails = self.search_mails_by_sender(opt['sender'], opt['data'], opt['sort'])
    # 上記のいずれのパラメータ指定もない場合
    else
      mails = self.search_mails(opt['data'], opt['sort'])
    end

    return mails
  end

  # 日付検索
  def self.search_mails_by_date(date, data, sort)
    if data == 'attachments'
      if sort == 'asc'
        mails = self.where("DATE_FORMAT(send_at,'%Y%m') = #{date}").where(:attach_flg => true).order('send_at ASC').limit(30)
      else
        mails = self.where("DATE_FORMAT(send_at,'%Y%m') = #{date}").where(:attach_flg => true).order('send_at DESC').limit(30)
      end
    else 
      if sort == 'asc'
        mails = self.where("DATE_FORMAT(send_at,'%Y%m') = #{date}").order('send_at ASC').limit(30)
      else
        mails = self.where("DATE_FORMAT(send_at,'%Y%m') = #{date}").order('send_at DESC').limit(30)
      end
    end

    return mails
  end

  # キーワード検索
  # FIXME: 添付ファイル名を検索する方法がわからず未実装（joinsメソッド、includeオプションの使いかた？)
  def self.search_mails_by_query(query, data, sort)
    if data == 'attachments'
      if sort == 'asc'
        mails = self.where(:attach_flg => true)
                    .where('body LIKE ? or subject LIKE ? or sender LIKE ?', "%#{query}%", "%#{query}%", "%#{query}%")
                    .order('send_at ASC')
                    .limit(30)
      else
        mails = self.where(:attach_flg => true)
                    .where('body LIKE ? or subject LIKE ? or sender LIKE ?', "%#{query}%", "%#{query}%", "%#{query}%")
                    .order('send_at DESC')
                    .limit(30)
      end
    else 
      if sort == 'asc'
        mails = self.where('body LIKE ? or subject LIKE ? or sender LIKE ?', "%#{query}%", "%#{query}%", "%#{query}%").order('send_at ASC').limit(30)
      else
        mails = self.where('body LIKE ? or subject LIKE ? or sender LIKE ?', "%#{query}%", "%#{query}%", "%#{query}%").order('send_at DESC').limit(30)
      end
    end

    return mails
  end

  # 送信者検索
  def self.search_mails_by_sender(sender, data, sort)
    if data == 'attachments'
      if sort == 'asc'
        mails = self.where('sender LIKE ?', "%#{sender}%").where(:attach_flg => true).order("send_at ASC").limit(30)
      else
        mails = self.where('sender LIKE ?', "%#{sender}%").where(:attach_flg => true).order("send_at DESC").limit(30)
      end
    else 
      if sort == 'asc'
        mails = self.where('sender LIKE ?', "%#{sender}%").order("send_at ASC").limit(30)
      else
        mails = self.where('sender LIKE ?', "%#{sender}%").order("send_at DESC").limit(30)
      end
    end

    return mails
  end

  def self.search_mails(data, sort)
    if data == 'attachments'
      if sort == 'asc'
        mails = self.where(:attach_flg => true).order("send_at ASC").limit(30)
      else
        mails = self.where(:attach_flg => true).order("send_at DESC").limit(30)
      end
    else 
      if sort == 'asc'
        mails = self.order("send_at ASC").limit(30)
      else
        mails = self.order("send_at DESC").limit(30)
      end
    end

    return mails
  end

  ## 送信者のメールアドレスの取得
  def self.search_sender_mail_addresses
    self.select('sender').group('sender').order('COUNT(sender) DESC')
  end

  ## 日付(年-月)毎の件数を取得する
  def self.search_by_send_at
    self.select("DATE_FORMAT(send_at,'%Y年%m月') as 'year_month', COUNT(id) as num, DATE_FORMAT(send_at, '%Y%m') as 'query_value'").group("DATE_FORMAT(send_at,'%Y年%m月') DESC")
  end

  ## 全メールの件数を取得する 
  def self.count_all_mails
    self.count
  end

  ## 添付ファイル月メールの件数を取得する
  def self.count_attach_mails
    self.where(:attach_flg => true).count
  end


end
