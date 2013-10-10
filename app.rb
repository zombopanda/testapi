# app.rb
require 'sinatra'
require 'sinatra/activerecord'

set :database, 'sqlite3:///db/testapi.db'

class OptIn < ActiveRecord::Base
  validates :email, :mobile, :first_name, :last_name, :permission_type, :channel, :company_name, presence: true
  validates_inclusion_of :channel, in: %w(sms email sms+email)
  validates_inclusion_of :permission_type, in: %w(one-time permanent)
end

before do
  content_type :json
end

# INDEX
get '/' do
  redirect to('/opt-ins')
end

# LIST
get '/opt-ins' do
  opt_ins = OptIn.order('created_at desc')
  opt_ins.to_json
end

# CREATE
post '/opt-ins' do
  opt_in = OptIn.new(params)

  if opt_in.save
    opt_in.to_json
  else
    halt 500
  end
end

# GET
get '/opt-ins/:id' do
  opt_in = OptIn.find(params[:id])
  opt_in.to_json
end

# UPDATE
put '/opt-ins/:id' do
  opt_in = OptIn.find(params[:id])

  if opt_in.update_attributes(params)
    opt_in.to_json
  else
    halt 500
  end
end