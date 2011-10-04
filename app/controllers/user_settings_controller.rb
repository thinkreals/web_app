class UserSettingsController < InheritedResources::Base
  belongs_to :user, :singleton => true

  def show
    show! do |format|
      format.html
      format.json { render_resource_json resource }
    end
  end

  def update   
    update! do |success, failure|    
      success.html
      success.json { redirect_to resource_url(format: 'json', v: params[:v]) }

      failure.html
      failure.json { render_fail_json resource.errors.messages }
    end
  end     

end
