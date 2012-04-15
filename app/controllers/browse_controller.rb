require 'json'
class BrowseController < ApplicationController
  def index
  end

  def fullsize
    @post = Post.find_by_unique_id(params[:unique_id])
  end

  def latest
    posts=[]
    Post.find(:all, :order => "created_at DESC", :offset => params[:offset], :limit => params[:limit]).each do |p|
      posts << p.json_object
    end

    render :json => posts.to_json
  end
end
