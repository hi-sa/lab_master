# -*- coding: utf-8 -*-
class MailController < ApplicationController
  layout "twitter"

  def index
    # params[:data] 全てのメールか添付ファイル付きのメールかでの絞込み
    # params[:sort] 降順か昇順（送信日）での絞込み
    # params[:sender] 送信主での絞込み
    # params[:search] 検索クエリでの絞込み
    # params[:date] 日付での絞込み
    # FIXME: 入れ子になりすぎている。もっとわかりやすく。

    search_options = params

    @mails = Mail.search_mails_with_params(search_options).page params[:page]

    # メールアドレスの取得
    @m_addresses = Mail.search_sender_mail_addresses

    # 日付ごとのメール数の取得
    @send_at_list = Mail.search_by_send_at

    # 全てのメールの件数を取得
    @count_mails = Mail.count_all_mails

    # 添付ファイル付きのメール件数を取得
    @count_attach_mails = Mail.count_attach_mails

  end

  def show
  end

  def edit
  end

  def update
  end

end
