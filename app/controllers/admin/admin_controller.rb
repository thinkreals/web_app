#encoding: utf-8

class Admin::AdminController < ApplicationController
  before_filter :authenticate_admin!
  layout 'admin'
  def authenticate_admin!
    unless user_signed_in? && current_user.admin?
      raise CanCan::AccessDenied, '접근권한이 없습니다.'
    end
  end
end
