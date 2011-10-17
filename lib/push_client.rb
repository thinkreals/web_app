=begin                               
<요구사항>
* 반드시 255 자 자를것.
* 디바이스로 로그인 시 user.app_deleted_at = nil
* 푸시 response 보고 앱 지운 사람들 app_deleted_at = Time.now
* 푸시 동의 + app_deleted_at 보고 푸시 보내기.
=end

require 'net/http'
require 'uri'

class PushClient
  def self.push(users, msg)
    # 1. push msg.
    url = URI.parse("http://dev-push.thinkreals.com/request/matgek.json")
    data = {     
      contents: [{
        user_list: users.select{|u| u.user_setting.app_deleted_at.nil? }.map(&:email),
        message: msg,
        custom_properties: "empty"
      }].to_json    
    }
    response = Net::HTTP.post_form(url, data)
    body = JSON.parse(response.body).first
    
    # 2. save failed email list..
    if body["failed_user_list"].any?
      body["failed_user_list"].each do |email|
        user_setting = UserSetting.joins(:user).where("users.email = ?", email).readonly(false).first
        user_setting.update_attributes app_deleted_at: Time.zone.now
      end
    end
    
    body
  end

end
