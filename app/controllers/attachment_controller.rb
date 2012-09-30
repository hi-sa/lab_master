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
  end

end
