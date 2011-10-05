Rails.application.config.middleware.use OmniAuth::Builder do  
  # provider :twitter, 'CONSUMER_KEY', 'CONSUMER_SECRET'  
  # provider :facebook, 'APP_ID', 'APP_SECRET'  
  # provider :linked_in, 'CONSUMER_KEY', 'CONSUMER_SECRET'
                                                             
  provider :twitter, CONFIG['twitter_consumer_key'], CONFIG['twitter_consumer_secret']
  provider :facebook, CONFIG['facebook_app_id'], CONFIG['facebook_app_secret'],{:scope => 'user_about_me,user_activities,email,offline_access,publish_stream,manage_friendlists'}        
end