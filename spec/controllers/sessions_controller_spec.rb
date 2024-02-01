# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  before(:each) do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({ info: { email: 'j@tamu.edu' } })
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]
    User.destroy_all
    CreditPool.destroy_all
    User.create({ name: 'Todd', uin: '654321', email: 'todd@tamu.edu', user_type: 'donor' })
    User.create({ name: 'Mark', uin: '324156', email: 'mark@tamu.edu', user_type: 'recipient' })
    CreditPool.create({ credits: 1 })
  end

  describe 'When logging in' do
    it 'redirect to new user creation page for new user' do
      request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]
      get :omniauth
      expect(response).to redirect_to '/users/new'
    end

    it 'changes session for already established user' do
      request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]
      User.create({ name: 'John', uin: '123456', email: 'j@tamu.edu', user_type: 'donor' })
      get :omniauth
      expect(session[:user_id]).to eq(User.find_by(email: 'j@tamu.edu').id)
    end
  end

  describe 'When logging out' do
    it 'clears the session' do
      get :logout, session: { user_id: User.find_by(uin: '654321').id }
      expect(response).to redirect_to '/'
    end
  end
end
