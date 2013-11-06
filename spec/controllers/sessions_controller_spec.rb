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
end
