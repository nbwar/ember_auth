require 'spec_helper'

describe UsersController do
  # let(:user) { FactoryGirl.create(:user) }

  it '#create' do
    post 'create', {
      user: {
        username: 'nick',
        email: 'nick@nick.com',
        password: 'secret',
        password_confirmation: 'secret'
      }
    }

    results = JSON.parse(response.body)
    results["api_key"]["access_token"] =~ /\S{32}/
    results["api_key"]["user_id"].should_not be_nil
  end

  it '#create with invalid data' do
    post 'create', {
      user: {
        username: '',
        email: 'nick@nick.com',
        password: 'secret',
        password_confirmation: 'secret'
      }
    }

    results = JSON.parse(response.body)
    results['errors']['username'].size.should be > 1
  end

  it '#show' do
    user = FactoryGirl.create(:user)
    post :show, { id: user.id }
    results = JSON.parse(response.body)
    results['user']['id'].should eq user.id
    results['user']['username'].should eq user.username
  end


  it '#index without token in header' do
    get :index
    expect(response.status).to eq(401)
  end

  it "#index with invalid token" do
    get :index, {}, {'Authorization' => 'Bearer 12345'}
    expect(response.status).to eq(401)
  end

  it "#index with expired token" do
    user = FactoryGirl.create(:user)
    expired_api_key = user.api_keys.session.create
    expired_api_key.update_attribute(:expired_at, 30.days.ago)
    get :index, {}, {'Authorization' => "Bearer #{expired_api_key.access_token}"}
    expect(response.status).to eq(401)
  end

  it "#index with valid token" do
    user = FactoryGirl.create(:user)
    api_key = user.session_api_key
    get :index, {}, { 'Authorization' => "Bearer #{api_key.access_token}"}
    results = JSON.parse(response.body)
    expect(results['users'].size).to eq(1)
  end
end
