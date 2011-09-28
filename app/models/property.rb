class Property < ActiveRecord::Base

  def readable_object(version, hash = nil)
    ret = {}
    
    case version.to_i
    when 1
       ret = { 
         id: id,            
         key: key,
         value: value,
         created_at: created_at.to_s(:normal_datetime)
       }
    end
    
    ret
  end    
 
end
