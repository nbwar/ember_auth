require 'spec_helper'

describe UsersController do

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
    results['errors'].size.should be > 1

  end




  # it '#new should render new template' do
  #   get :new
  #   response.should render_template('new')
  # end

  # it '#create should redirect to root_path if save is successful' do
  #   post :create, :user => { :username => 'Nick', :email => 'nick@nick.com', :password => 'password', :password_confirmation => 'password'}
  #   expect(response.status).to eq 302
  # end

  # it '#create should render new template if save is unsuccessful' do
  #   post :create, :user => { :username => 'Nick', :email => 'nick@nick.com', :password => 'password', :password_confirmation => 'wrong_pass'}
  #   response.should render_template('new')
  # end
end
