require 'spec_helper'

describe SessionsController do
  it 'should authenticate with username' do
    pw = 'secret'
    user = User.create!(username: 'nick', email: 'nick@nick.com', password: pw, password_confirmation: pw)
    post 'create', { username_or_email: user.username, password: pw}
    results = JSON.parse(response.body)
    results['api_key']['access_token'] =~ /\S{32}/
    results['api_key']['user_id'].should eq user.id
  end

  it 'should authenticate with email' do
    pw = 'secret'
    user = User.create!(username: 'nick', email: 'nick@nick.com', password: pw, password_confirmation: pw)
    post 'create', { username_or_email: user.email, password: pw}
    results = JSON.parse(response.body)
    results['api_key']['access_token'] =~ /\S{32}/
    results['api_key']['user_id'].should eq user.id
  end

  it 'should not authenticate with invalid info' do
    pw = 'secret'
    user = User.create!(username: 'nick', email: 'nick@nick.com', password: pw, password_confirmation: pw)
    post 'create', { username_or_email: user.email, password: 'wrong'}
    response.status.should eq 401

  end




















  # before(:each) do
  #   FactoryGirl.create(:user, email: 'nick@nick.com')
  # end

  # it '#new should render new template' do
  #   get :new
  #   response.should render_template('new')
  # end

  # it '#create should redirect if login was successful' do
  #   post :create, :session => { email: 'nick@nick.com', password: 'password' }
  #   expect(response.status).to eq 302
  # end

  # it '#create should render new if login was unsuccessful' do
  #   post :create, :session => { email: 'nick@nick.com', password: 'wrong_password' }
  #   response.should render_template('new')
  # end

  # it '#destroy should sign out a user' do
  #   post :create, :session => { email: 'nick@nick.com', password: 'password' }
  #   delete :destroy
  #   controller.current_user.should be_nil
  # end

  # it '#destroy should redirect' do
  #   post :create, :session => { email: 'nick@nick.com', password: 'password' }
  #   delete :destroy
  #   expect(response.status).to eq 302
  # end
end
