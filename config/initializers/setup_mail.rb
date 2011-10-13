ActionMailer::Base.smtp_settings = {  
  :address              => CONFIG['mail_host'],  
  :port                 => 25,  
  :domain               => CONFIG['mail_host'],  
  :authentication       => "plain",  
  :enable_starttls_auto => true  
}                                   

ActionMailer::Base.default_url_options = { :host => CONFIG['host'] } # for devise password mail
ActionMailer::Base.delivery_method = :smtp