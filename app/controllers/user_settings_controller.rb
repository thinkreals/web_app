class UserSettingsController < ApplicationController 
  before_filter :find_user
  
  def find_user
    @user = User.find(params[:user_id]) if params[:user_id].present?
  end
  
  def index
    @user_settings = UserSetting.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render_collection_json @user_settings }
    end
  end

  def show          
    @user_setting = @user.user_setting

    respond_to do |format|
      format.html # show.html.erb
      format.json { render_resource_json @user_setting }
    end
  end

  def edit
    @user_setting = @user.user_setting
  end


  def update
    @user_setting = @user.user_setting

    respond_to do |format|
      if @user_setting.update_attributes(params[:user_setting])
        format.html { redirect_to edit_user_user_setting_path(@user), notice: 'Successfully updated.' }
        format.json { redirect_to user_user_setting_path(user_id: @user.id, format: 'json', v: params[:v]) }
      else
        format.html { render action: "edit" }
        format.json { render_fail_json @user_setting.errors.messages }
      end
    end
  end

end
