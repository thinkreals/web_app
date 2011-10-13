require 'net/http'
require 'uri'

class PushClient
  API_URL = 'http://dev-push.thinkreals.com/request/matgek.json'
  
  def self.push(user, msg)
    contents = [{ 
      "user_list"         => [ user.email ], 
      "message"           => msg, 
      "custom_properties" => "" 
    }]
    
    res = Net::HTTP.post_form(URI.parse(API_URL), { contents: contents.to_json })
    puts res.body
  end
end
