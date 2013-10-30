require 'spec_helper'
require 'date'

describe ApiKey do
  let(:user) { FactoryGirl.create(:user) }

  it 'should generate access token' do
    api_key = ApiKey.create(scope: 'session', user_id: user.id)
    api_key.access_token.should_not be_nil
  end

  it 'should set the expired_at properly for session scope' do
    api_key = ApiKey.create(scope: 'session', user_id: user.id)
    api_key.expired_at.to_s.should eq 4.hours.from_now.to_s
  end

  it 'should set the expired_at properly for api scope' do
    api_key = ApiKey.create(scope: 'api', user_id: user.id)
    api_key.expired_at.to_s.should eq 30.days.from_now.to_s
  end

end
