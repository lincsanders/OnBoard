require 'json'

class BrowseController < ApplicationController
  STEP = 25

  def index
    @facebook_user = facebook_user
  end

  def fullsize
    @post = Post.find_by_unique_id(params[:unique_id])
    @post.increment(:rating)
    @post.save
  end

  def latest
    posts=[]
    Post.find(:all, :order => "created_at DESC", :limit => STEP).each do |p|
      posts << p.json_object
    end

    render :json => {
      posts: posts,
      next_url: next_url({:offset => STEP})
    }.to_json
  end

  def next
    posts=[]
    Post.find(:all, :order => "created_at DESC", :offset => params[:offset], :limit => STEP).each do |p|
      posts << p.json_object
    end

    render :json => {
      posts: posts,
      next_url: next_url({:offset => (params[:offset].to_i + STEP)}),
      reached_end: posts.empty?
    }.to_json
  end
end
