# coding: utf-8

class UserSetting < ActiveRecord::Base   
  # EDIT HERE
  SNS_TYPES = { 'facebook' => '페이스북', 'twitter' => '트위터', 'google' => 'google'}
  POST_SNS_TYPES = { 'like' => '좋아요', '...' => '...' }
  EMAIL_ME_TYPES = { 'comment' => '댓글알림' }
  PHONE_PUSH_TYPES = { 'follow' => '팔로우 알림' }
  

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
         post_sns_with:    post_sns_with,
         post_sns_when:    post_sns_when,
         email_me_when:    email_me_when,
         phone_push_when:  phone_push_when,
         email_agreed_at: string_email_agreed_at,
         term_agreed_at:  string_term_agreed_at,
         created_at: created_at.to_s(:normal_datetime),
         updated_at: updated_at.to_s(:normal_datetime)
       }
    end

    ret
  end                               
  
         
  def term_agree
    term_agreed_at ? true : false
  end
  def email_agree
    email_agreed_at ? true : false
  end
  def term_agree=(agree)  
    if agree == true or agree == 'true'
      self.term_agreed_at = Time.zone.now
    else
      self.term_agreed_at = nil
    end
  end
  def email_agree=(agree)
    if agree == true or agree == 'true'
      self.email_agreed_at = Time.zone.now
    else
      self.email_agreed_at = nil
    end
  end  
  
  def post_sns_with
    SNS_TYPES.keys - Util.to_array(do_not_post_sns_with)
  end
  def post_sns_when
    POST_SNS_TYPES.keys - Util.to_array(do_not_post_sns_when)
  end
  def email_me_when
     EMAIL_ME_TYPES.keys - Util.to_array(do_not_email_me_when)
  end
  def phone_push_when
    PHONE_PUSH_TYPES.keys - Util.to_array(do_not_phone_push_when)
  end 
  
  def post_sns_with=(array)       
    do_not = SNS_TYPES.keys - array
    self.do_not_post_sns_with = Util.to_string(do_not)
  end
  def post_sns_when=(array)       
    do_not = POST_SNS_TYPES.keys - array
    self.do_not_post_sns_when = Util.to_string(do_not)
  end
  def email_me_when=(array)       
    do_not = EMAIL_ME_TYPES.keys - array
    self.do_not_email_me_when = Util.to_string(do_not)
  end
  def phone_push_when=(array)       
    do_not = PHONE_PUSH_TYPES.keys - array
    self.do_not_phone_push_when = Util.to_string(do_not)
  end
    
end
