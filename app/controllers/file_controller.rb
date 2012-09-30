class FileController < ApplicationController
  layout "twitter"

  def index
    @attachments = Attachment.search_recent_attachments
  end

  def show
  end

  def download
  end

end
