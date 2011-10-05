class UsersController < ApplicationController
  load_and_authorize_resource 

  def show       
    @user = User.find(params[:id])
    
    respond_to do |format|
      format.html
      format.json { render_resource_json @user }
    end
  end

  def update     
    @user = User.find(params[:id])
    
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to root_path, :notice => 'Successfully updated.' }
        format.json { render_resource_json @user, :message => 'Successfully updated.' }
      else                                                                 
        format.html { render action: 'edit' }    
        format.json { render_fail_json @user.errors.messages }
      end

    end
  end 

  def password
    @user = User.find(params[:id])
     
    respond_to do |format|
      if request.get? 
        format.html

      elsif request.put?  
        if @user.update_with_password(params[:user])
          format.html { redirect_to root_path, :notice => 'Successfully updated.' }
          format.json { render_resource_json @user, :message => 'Successfully updated.' }
        else         
          format.html { render action: 'password' }
          format.json { render_fail_json @user.errors.messages }                                                       
        end  
      end

    end
  end    
  
  def email_check
    user = User.find_by_email(params[:email])
                
    respond_to do |format|
      if user.nil?
        format.js { render text: 'true' }
        format.json { render json: { status_code: 'success', message: 'Email is unique.' }.to_json }
      else
        format.js { render text: 'false' }
        format.json { render json: { status_code: 'fail', message: 'Email is NOT unique.' }.to_json }
      end
    end
  end
  
end
