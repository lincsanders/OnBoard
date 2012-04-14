class Post < ActiveRecord::Base

  def thumb_url
    "http://#{Rails.configuration.aws_bucket}.s3.amazonaws.com/#{file_name}"
  end

  def fullsize_url
    "asdasdasd"
  end
  
  def self.random_string
    rand(36**50).to_s(36)
  end

  # Scale images and stuff hurr purrhaps?
end
