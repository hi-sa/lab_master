# -*- coding: utf-8 -*-
class AttachmentController < ApplicationController
  layout "twitter"

  def index
    # URLパラメータの取得
    search_options = params

    # ファイルの取得
    @attachments = Attachment.search_files_with_params(search_options).page params[:page]

    # 条件に該当しているファイル件数の取得
    @showed_files_num = Attachment.count_showed_files(search_options)

    # 日付ごとのファイル数の取得
    @send_at_list = Attachment.search_by_send_at

    # 拡張子ごとのファイル数の取得
    @ext_list = Attachment.count_ext_num

    # 全てのファイルの件数を取得
    @all_file_num = Attachment.count_all_files

    # 送信者のメールアドレスの取得
    @m_addresses = Attachment.search_sender_mail_addresses
  end

  def show
  end

  def download
    # ダウンロード要求のあったファイルの情報を取得する
    file_info = Attachment.select_file_info(params[:id])

    # ファイルのダウンロードの実行
    begin
      send_file "public/ozaken/#{file_info[:file_id]}#{file_info[:ext]}", filename: file_info[:filename]
    rescue
      redirect_to attachment_index_path, alert: 'ファイルのダウンロードに失敗しました'
    end
  end

end
