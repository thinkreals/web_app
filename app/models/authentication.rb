# coding: utf-8

class Authentication < ActiveRecord::Base 
  PROVIDER_TYPES = { 'twitter' => '트위터', 'facebook' => '페이스북'}

  belongs_to :user

  validates_presence_of :provider, :uid, :message => "은 비울수 없습니다."
  validates_inclusion_of :provider, :in => PROVIDER_TYPES.keys

  scope :twitter, where(provider: 'twitter')
  scope :facebook, where(provider: 'facebook')        


  
end
