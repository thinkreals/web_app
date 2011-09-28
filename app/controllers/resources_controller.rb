class ResourcesController < InheritedResources::Base
  respond_to :html, :json  

  def index
    index! do |format|
      format.html
      format.json { render_collection_json collection }
    end
  end

  def show
    show! do |format|
      format.html
      format.json { render_resource_json resource }
    end
  end
  
  def update   
    update! do |success, failure|    
      success.html
      success.json { render_resource_json resource, :message => "Successfully updated." }  
      
      failure.html
      failure.json { render_fail_json resource.errors.messages }
    end
  end

  protected
  def collection
    end_of_association_chain.page(params[:page]).per(params[:per_page])
  end
end
