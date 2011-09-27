class ApplicationController < ActionController::Base
  # protect_from_forgery  
  
  def render_resource_json(resource, hash = {})
    name = resource.class.name.underscore
    hash[:current_user] = current_user
    
    render json: {   
      status_code: 'success',
      message: hash[:message] || 'Success.',                    
      name => resource.readable_object(params[:v], hash)
    }
  end                  
  
  def render_collection_json(collection, hash = {})
    name = collection.klass.name.pluralize.underscore
    hash[:current_user] = current_user
    
    render json: {
      status_code: 'success',
      message: hash[:message] || 'Success.',
      page: params[:page],
      per_page: params[:per_page],
      total_count: collection.total_count,
      name => collection.map{|resource| resource.readable_object(params[:v], hash) }
    }
    
  end
  
  def render_success_json(msg = nil)
    render json: {
      status_code: 'success',
      message: msg || 'Success.'
    }
  end                           
  
  def render_fail_json(msg = nil)
    render json: {
      status_code: 'fail',
      message: msg || 'Fail.'
    }
  end
  
  def render_require_auth_json(msg = nil)
    render json: {
      status_code: 'require_auth',
      message: msg || 'Please sign in.'
    }
  end
end
