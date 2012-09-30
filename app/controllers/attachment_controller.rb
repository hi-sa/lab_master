class AttachmentController < ApplicationController
  layout "twitter"

  def index
    @attachments = Attachment.search_recent_attachments
    @send_at_list = Attachment.search_by_send_at
    @ext_list = Attachment.count_ext_num
    @file_count = Attachment.count_files
  end

  def show
  end

  def download
  end

end
