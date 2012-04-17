class AdminController < ApplicationController
  before_filter :require_login
  
  skip_before_filter :require_login, :only => [:login]
  
  def login
    if !session[:user].nil?
      redirect_to unconfirmed_images and return
    end
    if request.post?
      if session[:user] = Moderator.authenticate(params[:user][:username], params[:user][:password])
        flash[:message]  = "Login successful"
        redirect_to admin_url
      else
        flash[:warning] = "Login unsuccessful"
      end
    end
  end

  def index
    redirect_to :action => 'confirmed_posts'
  end

  def unconfirmed_posts
    @action = 'unconfirmed'
    @posts = Post.unconfirmed.latest.paginate :page => params[:page], :per_page => 12
    render 'posts', :layout => 'admin'
  end

  def confirmed_posts
    @action = 'confirmed'
    @posts = Post.confirmed.latest.paginate :page => params[:page], :per_page => 12
    render 'posts', :layout => 'admin'
  end

  def confirm_post
    @post = Post.find(params[:id])
    @post.approved = true
    @post.save

    flash[:message]  = "#{@post.image_title ? @post.image_title : "Post id: "+@post.id.to_s} approval successful"
    redirect_to params[:return_url] ? params[:return_url] : unconfirmed_posts_url
  end

  def unconfirm_post
    @post = Post.find(params[:id])
    @post.approved = false
    @post.save

    flash[:message]  = "#{@post.image_title ? @post.image_title : "Post id: "+@post.id.to_s} dissapproval successful"
    redirect_to params[:return_url] ? params[:return_url] : unconfirmed_posts_url
  end

  def delete_post
    @post = Post.find(params[:id])
    @post.delete

    flash[:message]  = "#{@post.image_title ? @post.image_title : "Post id: "+@post.id.to_s} deleted successful"
    redirect_to params[:return_url] ? params[:return_url] : unconfirmed_posts_url
  end
  
  def logout
    session[:user] = nil
    flash[:notice] = 'Logged out'
    redirect_to :action => 'login'
  end
  
  private

  def require_login
    if session[:user].nil?
      flash[:warning] = "You must be logged in to access this section"
      redirect_to admin_login_url
    end
  end
  
end
