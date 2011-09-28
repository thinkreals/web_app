class UsersController < ResourcesController 
  # user 의 경우 디바이스 때문에 json response 를 통제하기가 넘 어려워서 그냥 이렇게 씀... 좋은 방법 없을까?!..
  def update 
    if resource.update_attributes(params[:user])
       render_resource_json resource, :message => 'Successfully updated.'
    else                                                                
      render_fail_json resource.errors.messages
    end
  end 
  
  def password 
    if resource.update_with_password(params[:user])
       render_resource_json resource, :message => 'Successfully updated.'
    else                                                                
      render_fail_json resource.errors.messages
    end
  end 
end
