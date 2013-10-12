require 'sinatra'
require 'sinatra/activerecord'

set :database, 'sqlite3:///db/testapi.db'

class OptIn < ActiveRecord::Base
  validates :email, :mobile, :first_name, :last_name, :permission_type, :channel, :company_name, presence: true
  validates_inclusion_of :channel, in: %w(sms email sms+email)
  validates_inclusion_of :permission_type, in: %w(one-time permanent)
  validates_uniqueness_of :company_name, :scope => :channel

  def as_json(options)
    super options.merge(except: [:id, :created_at, :updated_at])
  end
end

before do
  content_type :json
end

# CREATE
post '/opt-ins' do
  opt_in = OptIn.find_or_initialize_by channel: params[:channel], company_name: params[:company_name]
  opt_in.attributes = params

  if opt_in.save
    opt_in.to_json
  else
    halt 400, opt_in.errors.to_json
  end
end