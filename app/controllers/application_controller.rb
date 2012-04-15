class ApplicationController < ActionController::Base
  protect_from_forgery
  @header_tags=""

  private
  def facebook_user
    return @facebook_user if @facebook_user

    begin
      fb_graph = open("https://graph.facebook.com/#{params[:fb_uid]}?access_token="+params[:fb_access_token])
      fb_user = JSON.parse(fb_graph.read)
    rescue
      return nil
    end

    @facebook_user = fb_user

    return @facebook_user if !@facebook_user['id'].nil?

    return nil

  end
end
