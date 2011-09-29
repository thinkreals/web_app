class UsersController < ResourcesController 
  load_and_authorize_resource 
  
  def index
    index! do |format|
      format.html
      format.json { render_collection_json collection }
    end
  end

  def show
    show! do |format|
      format.html
      format.json { render_resource_json resource, :include => [:user_setting] }
    end
  end
  
  
  
  # user 의 경우 디바이스 때문에 json response 를 통제하기가 넘 어려워서 그냥 이렇게 씀... 좋은 방법 없을까?!..
  def update  
    respond_to do |format|
      if resource.update_attributes(params[:user])
        format.html { redirect_to root_path, :notice => 'Successfully updated.' }
        format.json { render_resource_json resource, :message => 'Successfully updated.' }
      else                                                                 
        format.html { render action: 'edit' }    
        format.json { render_fail_json resource.errors.messages }
      end
      
    end
  end 
  
  def password 
    respond_to do |format|
      if request.get? 
        format.html

      elsif request.put?  
        if resource.update_with_password(params[:user])
          format.html { redirect_to root_path, :notice => 'Successfully updated.' }
          format.json { render_resource_json resource, :message => 'Successfully updated.' }
        else         
          format.html { render action: 'password' }
          format.json { render_fail_json resource.errors.messages }                                                       
        end  
      end
      
    end
  end 
end
