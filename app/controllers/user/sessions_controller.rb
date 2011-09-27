class User::SessionsController < Devise::SessionsController
  def create
    respond_to do |format|
      format.html { super }
      format.json { 
        warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#fail")
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