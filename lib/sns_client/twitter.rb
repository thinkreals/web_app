class SnsClient::Twitter 
  def initialize(authentication)
    @client = Twitter::Client.new(:oauth_token => authentication.token, :oauth_token_secret => authentication.secret)
  end                 
  
  def post(msg, options = {}) 
    @client.update(msg)
  end  
  
  def friend(id)           
    hashie_mash = Twitter.user(id)
    get_base_format_friend(hashie_mash)
  end          
  
  def friends(options = {})        
    hashie_mash = @client.friend_ids # => return max 5,000 IDs. (order by follow date)
    ids = hashie_mash['ids'][ (options[:offset] || 0), (options[:limit] || 25) ]
    
    if ids.blank? then []
    else
      Twitter.users(ids).map {|mash| get_base_format_friend(mash) }
    end
  end
  
  def total_friends_count
    @client.user.friends_count 
  end       
  
  def get_base_format_friend(friend)
    {    
      provider: 'twitter',               
      id: friend.id,
      name: friend.name,
      profile_image: friend.profile_image_url
    }
  end
end