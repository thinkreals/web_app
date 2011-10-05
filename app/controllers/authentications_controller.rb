# coding: utf-8

class AuthenticationsController < ApplicationController
  def create
    respond_to do |format|  
      format.html{                                                                                
        auth_hash = get_authentication_hash(request.env["omniauth.auth"])   
                
        if current_user                  
          auth_hash[:user_id] = current_user.id
          Authentication.create(auth_hash)
          redirect_to edit_user_path(current_user), notice: '연됭되었음.'
        else    
          session[:auth_hash] = auth_hash
          redirect_to new_user_registration_url
        end
      } 

      format.json{
        begin  
          ActiveRecord::Base.transaction do   
            @authentication = Authentication.new(params[:authentication])

            if @authentication.save
              redirect_to "/v/#{params[:v]}/authentications/#{@authentication.id}.json"
            else                                                                                                                    
              render json: invalid_record_json(@authentication) 
            end
          end
        rescue Exception => e
          render json: exception_json(e)
        end
      }
    end                                              
  end  
  
  
  def auth_failure
    render text: "/auth/failure"
  end




  # DELETE /authentications/1
  # DELETE /authentications/1.json
  def destroy
    @authentication = Authentication.find(params[:id])
    @authentication.destroy

    respond_to do |format|
      format.html { redirect_to edit_user_path(current_user), notice: '연동 해재.' }
      format.json { head :ok }
    end
  end  



  private

  def get_authentication_hash(omniauth)      

    authentication_hash = {:provider => omniauth['provider'], :uid => omniauth['uid']}
    if omniauth['user_info']
      #authentication_hash[:name] = omniauth['user_info']['name'] if omniauth['user_info']['name']
      authentication_hash[:nickname] = omniauth['user_info']['nickname'] if omniauth['user_info']['nickname']
      if omniauth['provider'] == 'facebook' && omniauth['user_info']['urls']
        authentication_hash[:url] = omniauth['user_info']['urls']['Facebook'] if omniauth['user_info']['urls']['Facebook']
      end
    end
    if omniauth['credentials']
      authentication_hash[:token] = omniauth['credentials']['token'].to_s if omniauth['credentials']['token']
      authentication_hash[:secret] = omniauth['credentials']['secret'].to_s if omniauth['credentials']['secret']
    end
    if omniauth['extra'] && omniauth['extra']['user_hash']
      authentication_hash[:email] = omniauth['extra']['user_hash']['email'] if omniauth['extra']['user_hash']['email']
    end

    if omniauth['provider'] == 'facebook'
      authentication_hash[:image_url] = "http://graph.facebook.com/#{omniauth['uid']}/picture?type=large"
    elsif omniauth['provider'] == 'twitter'
      #image = "http://a2.twimg.com/profile_images/235421510/jaehyun_normal.jpg"
      image = omniauth['user_info']['image']
      ridx = image.rindex("_normal")
      authentication_hash[:image_url] = "#{image[0, ridx]}#{image[ridx+8-1, image.length-ridx+8]}"
    end


    if authentication_hash[:nickname].blank? && authentication_hash[:email].present?
      authentication_hash[:nickname] = authentication_hash[:email].split('@').first 
    end


    authentication_hash
  end
  
  
end
