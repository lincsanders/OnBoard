require 'open-uri'
require 'json'

class UploadController < ApplicationController

  def index
  end

  def submit
    if(!facebook_user)
      flash[:notice] = 'Please login to facebook to post images'
      redirect_to upload_url and return
    end

    extensions = {'image/jpeg' => 'jpeg', 'image/png' => 'png'}

    params[:image_upload].each do |file|
      if file.content_type == 'image/jpeg' or file.content_type == 'image/png'
        post = Post.create(:mime_type => file.content_type, :size => file.size, :uploaded_by => params[:fb_uid], :file_name => Post.random_filename(File.extname(file.original_filename)))
        post.save_images file
      end
    end

    redirect_to upload_url and return
  end
end
