require "digest"

class Moderator < ActiveRecord::Base
  after_validation :encrypt_password

  @unenc_password = ""

  def self.authenticate(username, pass)
    u=find(:first, :conditions=>["username = ?", username])
    return nil if u.nil?
    if self.encrypted_password(pass) == u.password
      u.update_attribute(:login_time, Time.now) and return u
    end
    nil
  end

  def password_entry=(pwd)
    @unenc_password = pwd
  end

  def password_entry
    @unenc_password
  end

  private

  def self.encrypted_password(pass)
    Digest::MD5.hexdigest(ENV['SALT']+pass+ENV['SALT'])
  end

  def encrypt_password
    self.password = Moderator.encrypted_password(self.password_entry)
  end
end
