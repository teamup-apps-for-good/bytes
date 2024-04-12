# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SessionsController do
  before do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({ info: { email: 'j@tamu.edu' } })
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]
    User.destroy_all
    CreditPool.destroy_all
    User.create({ name: 'Todd', uid: '654321', email: 'todd@tamu.edu', user_type: 'donor' })
    User.create({ name: 'Mark', uid: '324156', email: 'mark@tamu.edu', user_type: 'recipient' })
    CreditPool.create({ credits: 1 })
  end

  describe 'When logging in' do
    it 'redirect to new user creation page for new user' do
      stub_request(:get, 'https://tamu-dining-62fbd726fd19.herokuapp.com/administrators/j@tamu.edu/validate_admin')
        .to_return(status: 200, body: 'true', headers: {})
      request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]
      get :omniauth
      expect(response).to redirect_to '/users/new'
    end

    it 'changes session for already established user' do
      stub_request(:get, 'https://tamu-dining-62fbd726fd19.herokuapp.com/administrators/j@tamu.edu/validate_admin')
        .to_return(status: 200, body: 'true', headers: {})
      request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]
      User.create({ name: 'John', uid: '123456', email: 'j@tamu.edu', user_type: 'donor' })
      get :omniauth
      expect(session[:user_id]).to eq(User.find_by(email: 'j@tamu.edu').id)
    end

    it 'sets admin value for the user through api call' do
      stub_request(:get, 'https://tamu-dining-62fbd726fd19.herokuapp.com/administrators/j@tamu.edu/validate_admin')
        .to_return(status: 200, body: 'true', headers: {})
      User.create({ name: 'John', uid: '123456', email: 'j@tamu.edu', user_type: 'donor' })
      get :omniauth
      expect(User.find_by(email: 'j@tamu.edu').admin).to eq(true)
    end
  end

  describe 'When logging out' do
    it 'clears the session' do
      get :logout, session: { user_id: User.find_by(uid: '654321').id }
      expect(response).to redirect_to '/'
    end
  end
end
