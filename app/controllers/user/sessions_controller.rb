class User::SessionsController < Devise::SessionsController
  def create
    respond_to do |format|
      format.html { super }
      format.json { 
        warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#fail")
          
        # device로 로그인 시 app_delete_at를 초기화 해준다. 
        if (!params[:device].blank?) and (params[:device].in? %w( ios android ))
          user = User.find_by_email(params[:user][:email])
          user.user_setting.update_attributes app_deleted_at: nil
        end
        
        render_success_json('Successfully signed in.')
      } 
    end
  end 

  # response by json format when login fail.
  def fail    
    render_fail_json(flash[:alert])
  end
  
  def destroy
    respond_to do |format|
      format.html { super }
      format.json {
        sign_out(current_user)  
        render_success_json('Successfully signed out.')
      }
    end
  end
end