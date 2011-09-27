class ApplicationController < ActionController::Base
  # protect_from_forgery
  
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
