class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable

  # Setup accessible (or protected) attributes for your model
  # attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_protected :id, :encrypted_password,:reset_password_token, :reset_password_sent_at, :remember_created_at, :sign_in_count, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip, :password_salt, :authentication_token, :created_at, :updated_at

  def readable_object(version, hash = nil)
    ret = {}
    
    case version.to_i
    when 1
       ret = { 
         id: id,            
         email: email,
         authentication_token: authentication_token,
         nickname: nickname,
         bio: bio,
         homepage: homepage,  
         
       }
    end
    
    ret
  end    
  

end
