class SnsClient::Facebook 
  FRIEND_FIELDS = "name, picture"
  
  def initialize(authentication)
    @graph = Koala::Facebook::API.new(authentication.token)
  end
  
  def post(msg, options = {})  
    @graph.put_wall_post(msg, options, options[:to] || 'me')
  end       
  
  def friend(id)
    obj = @graph.get_object(id, :fields => FRIEND_FIELDS)
    get_base_format_friend(obj)
  end
  
  def friends(options = {})
    graph_collection = @graph.get_connections("me", "friends", 
      :offset => options[:offset] || 0, :limit => options[:limit] || 25, :fields => FRIEND_FIELDS)
    
    if graph_collection.blank? then []
    else
      graph_collection.map {|g| get_base_format_friend(g) }
    end 
  end  
  
  def total_friends_count 
    id = @graph.get_object("me")["id"]
    result = @graph.fql_query("SELECT friend_count FROM user WHERE uid = '#{id}'")          
    result.first["friend_count"]
  end
  
  def get_base_format_friend(friend)
    {    
      provider: 'facebook',               
      id: friend['id'],
      name: friend['name'],
      profile_image: friend['picture']
    }
  end
end