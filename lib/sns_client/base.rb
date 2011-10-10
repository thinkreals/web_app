=begin
 SAMPLE USAGE:
                          
  user = User.last
  client = SnsClient::Base.new(user, 'facebook')
  if client
    client.post("hello world")      
    client.post("hello world", :to => '20975438798723')     
    client.friends(:offset => 0, :limit => 10)
    client.friend('209398746983') 
    client.total_friends_count            
  end  
  
=end
class SnsClient::Base 
  attr_reader :user, :provider, :authentication

  def initialize(user, provider)
    @user, @provider = user, provider

    if @authentication = user.authentications.where(provider: provider).first
      @client = class_eval("SnsClient::#{provider.classify}").new(@authentication)
    end
  end  
  
  def post(msg, options = {})
    @client.post(msg, options)
  end                 
  
  def friend(id)
    @client.friend(id)
  end  
                          
  def friends(options = {})
    @client.friends(options)
  end  
  
  def total_friends_count
    @client.total_friends_count
  end       
end