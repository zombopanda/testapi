require 'spec_helper'

describe 'TestApi' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it 'redirects on main' do
    get '/'
    last_response.should be_redirect
  end

  it 'gets opt-ins' do
    get '/opt-ins'
    last_response.should be_ok

    body = JSON.parse(last_response.body)
    body.should be_instance_of Array
  end
end

