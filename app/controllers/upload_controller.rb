require 'right_aws'
require 'open-uri'
require 'json'

class UploadController < ApplicationController
  include RightAws

  def index
  end

  def submit
    if(!@facebook_user)
      flash[:notice] = 'Please login to facebook to post images'
      redirect_to upload_url
    end

    extensions = {'image/jpeg' => 'jpeg', 'image/gif' => 'gif', 'image/png' => 'png'}

    s3 = S3.new(ENV['WF_AWS_KEY'], ENV['WF_AWS_SECRET'])
    bucket = s3.bucket(Rails.configuration.aws_bucket, true, 'public-read')

    params[:image_upload].each do |file|
      if file.content_type == 'image/jpeg' or file.content_type == 'image/gif' or file.content_type == 'image/png'
        post = Post.create(:mime_type => file.content_type, :size => file.size, :uploaded_by => params[:fb_uid])

        filename = Post.random_filename(File.extname(file.original_filename))
        s3file = S3::Key.create(bucket, filename)
        s3file.put(file.read)
      end
    end

    redirect_to '/'
  end
end
