# -*- coding: utf-8 -*-
# +------------+--------------+------+-----+---------+----------------+
# | Field      | Type         | Null | Key | Default | Extra          |
# +------------+--------------+------+-----+---------+----------------+
# | id         | int(11)      | NO   | PRI | NULL    | auto_increment |
# | title      | varchar(255) | YES  |     | NULL    |                |
# | summary    | text         | YES  |     | NULL    |                |
# | url        | varchar(200) | YES  | UNI | NULL    |                |
# | author     | varchar(50)  | YES  |     | NULL    |                |
# | image      | varchar(255) | YES  |     | NULL    |                |
# | posted_at  | datetime     | YES  |     | NULL    |                |
# | created_at | datetime     | NO   |     | NULL    |                |
# | updated_at | datetime     | NO   |     | NULL    |                |
# +------------+--------------+------+-----+---------+----------------+
# registerd_blog_idを追加する必要がある
class Blog < ActiveRecord::Base
  attr_accessible :title, :summary, :url, :author, :image, :posted_at

  belongs_to :registered_blog
  scope :new, order('posted_at DESC')
  scope :old, order('posted_at ASC')
  scope :top50, limit(50)
  scope :top30, limit(30)
  scope :top100, limit(100)

  # Kaminari(ページネーション)の設定。1ページに表示する件数
  paginates_per 20

  # エントリを日付ごとに集計する
  def self.list_up_blog_entry_by_date
    #select DATE_FORMAT(posted_at, '%Y%m') as date from blogs group by date;
    self.find_by_sql("select DATE_FORMAT(posted_at, '%Y%m') as entry_date, count(*) as counter from blogs group by entry_date;")
  end


  # 条件(パラメータ）を元にエントリの検索をし、取得する
  def self.search_entry_with_params(opt)
    # パラメータに検索クエリがある場合
    if opt['q']
      entries = self.search_entries_by_query(opt['q'], opt['sort'])
    # パラメータにタイトル指定がある場合
    elsif opt['blog_id']
      entries = self.search_entries_by_blog_id(opt['blog_id'], opt['sort'])
    else
      entries = self.search_entries(opt['sort'])
    end

    return entries
  end


  def self.search_entries_by_query(query, sort)
    if sort == 'asc'
      entries = self.where('title LIKE ? or summary LIKE ?', "%#{query}%", "%#{query}%").old
    else
      entries = self.where('title LIKE ? or summary LIKE ?', "%#{query}%", "%#{query}%").new
    end
    return entries
  end


  def self.search_entries_by_blog_id(blog_id, sort)
    if sort == 'asc'
      entries = self.where('registered_blog_id = ?', "#{blog_id}").old
    else
      entries = self.where('registered_blog_id = ?', "#{blog_id}" ).new
    end
    return entries
  end


  def self.search_entries(sort)
    if sort == 'asc'
      entries = self.old
    else
      entries = self.new
    end
    return entries
  end

end
