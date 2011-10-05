class Sns
  def self.post(authentication, msg)
    self.send("post_#{authentication.provider}", authentication, msg)
  end  
  
  def self.get_friends(authentication)
    self.send("get_#{authentication.provider}_friends", authentication)
  end
         
      
  protected   
  
  def self.config_twitter(authentication)
    Twitter.configure do |config|
      config.consumer_key = CONFIG['twitter_consumer_key']
      config.consumer_secret = CONFIG['twitter_consumer_secret']
      config.oauth_token = authentication.token
      config.oauth_token_secret = authentication.secret
    end
  end
  
  def self.post_twitter(authentication, msg)  
    self.config_twitter(authentication)

    begin
      Twitter.update(msg)
    rescue Exception => e
      puts e.message; pp e.backtrace
    else
      puts "Done."
    end
  end                  

  def self.post_facebook(authentication, msg)  
    graph = Koala::Facebook::API.new(authentication.token)
    graph.put_wall_post(msg)
  end
  
  
  def self.get_facebook_friends(authentication)
    graph = Koala::Facebook::API.new(authentication.token)
    graph.get_connections("me", "friend")
  end  
  
  def self.get_twitter_friends(authentication) 
    self.config_twitter(authentication)
    
    client = Twitter::Client.new  
    client.friend_ids['ids']
    
    
    
    
  end                    
  
  
  
end
