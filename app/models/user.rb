# coding: utf-8

class User < ActiveRecord::Base                                                         
  has_one :user_setting
  accepts_nested_attributes_for :user_setting
  has_many :authentications  
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable
  before_save :ensure_authentication_token                

  # Setup accessible (or protected) attributes for your model
  # attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_protected :id, :encrypted_password,:reset_password_token, :reset_password_sent_at, :remember_created_at, :sign_in_count, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip, :password_salt, :authentication_token, :created_at, :updated_at     
  
  validates_format_of :email, :with =>  /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => "은 형식이 올바르지 않습니다."  

  def admin?
    (self.id == 1) ? true : false
  end    
  
  def readable_object(version, current_user, includes = [])
    ret = {}

    case version.to_i
    when 1
       ret = {
         id: id,
         email: email,
         authentication_token: authentication_token,
         nickname: nickname,
         created_at: created_at.to_s(:normal_datetime),
         updated_at: updated_at.to_s(:normal_datetime)
       }
       if includes.include?(:user_setting)
         ret[:user_setting] = nil
         if user_setting
           ret[:user_setting] = user_setting.readable_object(version, current_user) 
         end
       end
    end

    ret
  end       
   
  
  def get_sns_client(provider)
    SnsClient::Base.new(self, provider)
  end
end
