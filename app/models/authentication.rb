# coding: utf-8

class Authentication < ActiveRecord::Base 
  PROVIDER_TYPES = { 'twitter' => '트위터', 'facebook' => '페이스북'}

  belongs_to :user

  validates_presence_of :provider, :uid, :message => "은 비울수 없습니다."
  validates_inclusion_of :provider, :in => PROVIDER_TYPES.keys

  scope :twitter, where(provider: 'twitter')
  scope :facebook, where(provider: 'facebook')        


  def post_twitter(msg)  
    Twitter.configure do |config|
      config.consumer_key = CONFIG['twitter_consumer_key']
      config.consumer_secret = CONFIG['twitter_consumer_secret']
      config.oauth_token = token
      config.oauth_token_secret = secret
    end

    begin
      Twitter.update(msg)
    rescue Exception => e
      puts "fail."
      puts e.message
      pp e.backtrace
    else
      puts "Done."
    end
  end                  

  def post_facebook

  end
end
