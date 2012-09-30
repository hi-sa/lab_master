# -*- coding: utf-8 -*-
class MailController < ApplicationController
  layout "twitter"

  def index
    # URLパラメータ一覧
    # params[:data] 全てのメールか添付ファイル付きのメールかでの絞込み
    # params[:sort] 降順か昇順（送信日）での絞込み
    # params[:sender] 送信主での絞込み
    # params[:search] 検索クエリでの絞込み
    # params[:date] 日付での絞込み

    # URLパラメータの取得
    search_options = params
    # メールの取得
    @mails = Mail.search_mails_with_params(search_options).page params[:page]

    # 条件に該当しているメール件数の取得
    @showed_mails_num = Mail.count_showed_mails(search_options)

    # メールアドレスの取得
    @m_addresses = Mail.search_sender_mail_addresses

    # 日付ごとのメール数の取得
    @send_at_list = Mail.search_by_send_at

    # 全てのメールの件数を取得
    @all_mails_num = Mail.count_all_mails

    # 添付ファイル付きのメール件数を取得
    @attach_mails_num = Mail.count_attach_mails

  end

  def show
  end

  def edit
  end

  def update
  end

end
