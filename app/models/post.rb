require 'right_aws'
require 'mini_magick'

class Post < ActiveRecord::Base
  before_save :set_identifiers

  LARGE = 1368
  MEDIUM = 198
  SMALL = 75

  def s3_base; "http://#{Rails.configuration.aws_bucket}.s3.amazonaws.com/"; end
  def facebook_user_image; "http://graph.facebook.com/#{uploaded_by}/picture"; end

  def large_filename; "#{unique_id}/large_#{file_name}"; end
  def medium_filename; "#{unique_id}/medium_#{file_name}"; end
  def small_filename; "#{unique_id}/small_#{file_name}"; end

  def large_url; s3_base + large_filename; end
  def medium_url; s3_base + medium_filename; end
  def small_url; s3_base + small_filename; end
  
  def random_unique_id
    random_string = rand(36**50).to_s(36)
    random_string = rand(36**50).to_s(36) while Post.exists?(:unique_id => random_string)
    random_string
  end
  
  def self.random_filename(ext)
    rand(36**12).to_s(36) + ext
  end
  
  def save_images(file)
    file_contents = file.read

    s3 = RightAws::S3.new(ENV['WF_AWS_KEY'], ENV['WF_AWS_SECRET'])
    bucket = s3.bucket(Rails.configuration.aws_bucket)

    #Resize the image to be within the max size constraints for each size
    img = MiniMagick::Image.read(file_contents)

    img.resize "#{LARGE.to_s}" if img['width'] > LARGE
    s3file = RightAws::S3::Key.create(bucket, large_filename).put(img.to_blob, 'public-read')

    img.resize "#{MEDIUM.to_s}X#{MEDIUM.to_s}" if img['width'] > MEDIUM || img['height'] > MEDIUM
    s3file = RightAws::S3::Key.create(bucket, medium_filename).put(img.to_blob, 'public-read')

    img.resize "#{SMALL.to_s}X#{SMALL.to_s}" if img['width'] > SMALL || img['height'] > SMALL
    s3file = RightAws::S3::Key.create(bucket, small_filename).put(img.to_blob, 'public-read')

    true
  end

  private
  def set_identifiers
    self.unique_id = random_unique_id
  end
end
