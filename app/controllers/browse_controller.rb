require 'json'
class BrowseController < ApplicationController
  def index
  end

  def latest
    posts=[]
    Post.find(:all, :order => "created_at DESC", :offset => params[:offset], :limit => params[:limit]).each do |p|
      posts << {
        large_url: p.large_url,
        medium_url: p.medium_url,
        small_url: p.small_url,
        facebook_user_image: p.facebook_user_image,
      }
    end

    render :json => posts.to_json
  end
end
