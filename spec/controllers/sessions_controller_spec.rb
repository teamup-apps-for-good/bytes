require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'GET omniauth' do
    context 'with valid OmniAuth data' do
      before do
        OmniAuth.config.test_mode = true
        OmniAuth.config.add_mock(
          :google_oauth2,
          uid: '123456',
          info: { email: 'example@tamu.edu', name: 'Test User' }
        )
        request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]
      end

      it 'signs in user' do
        get :omniauth
      end
    end
  end
end
