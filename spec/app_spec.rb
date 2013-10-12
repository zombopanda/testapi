require 'spec_helper'

describe 'TestApi' do
  include Rack::Test::Methods

  let(:data) do
    {
      'first_name' => 'Ivan',
      'last_name' => 'Ivanov',
      'email' => 'test@gmail.com',
      'mobile' => '+380631234567',
      'permission_type' => 'permanent',
      'channel' => 'sms+email',
      'company_name' => 'Company23'
    }
  end

  def app
    Sinatra::Application
  end

  it 'creates opt-ins' do
    post '/opt-ins', data
    last_response.should be_ok

    body = JSON.parse(last_response.body)
    body.should == data
    OptIn.count.should == 1
  end

  it 'updates post-ins' do
    post '/opt-ins', data
    last_response.should be_ok

    new_data = data.merge('first_name' => 'Oleg')
    post '/opt-ins', new_data
    last_response.should be_ok

    body = JSON.parse(last_response.body)
    body.should == new_data
    OptIn.count.should == 1
  end

  it 'validates post-in' do
    data.delete('channel')
    post '/opt-ins', data
    last_response.status.should == 400
  end
end

