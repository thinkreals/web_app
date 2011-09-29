class UserSetting < ActiveRecord::Base
  belongs_to :user   
  validates_presence_of :term_agreed_at                                      
  
  def readable_object(version, current_user, includes = [])
    ret = {}   

    case version.to_i 
    when 1     
      string_email_agreed_at = email_agreed_at ? email_agreed_at.to_s(:normal_datetime) : nil
      string_term_agreed_at = term_agreed_at ? term_agreed_at.to_s(:normal_datetime) : nil
      
       ret = {
         id: id, 
         user_id: user_id,
         post_sns_withs: post_sns_withs,
         post_sns_whens: post_sns_whens,
         email_me_whens: email_me_whens,
         phone_push_me_whens: phone_push_me_whens,
         email_agreed_at: string_email_agreed_at,
         term_agreed_at: string_term_agreed_at,
         created_at: created_at.to_s(:normal_datetime),
         updated_at: updated_at.to_s(:normal_datetime)
       }
    end

    ret
  end                               
  
  
  def term_agree=(agree)
    self.term_agreed_at = Time.zone.now if agree == true or agree == 'true'
  end
  
  def email_agree=(agree)
    self.email_agreed_at = Time.zone.now if agree == true or agree == 'true'
  end  
  
  
  def post_sns_withs
    post_sns_with ? post_sns_with.split(",") : []
  end

  def post_sns_whens
    post_sns_when ? post_sns_when.split(",") : []
  end

  def email_me_whens
    email_me_when ? email_me_when.split(",") : []
  end

  def phone_push_me_whens
    phone_push_me_when ? phone_push_me_when.split(",") : []
  end
    
end
