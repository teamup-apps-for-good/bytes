# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreditPoolsController, type: :controller do
  before(:all) do
    User.destroy_all
    CreditPool.destroy_all
    CreditPool.create({ credits: 1 })

    user = User.create(name: 'John', uin: '123456', email: 'j@tamu.edu', credits: '50', user_type: 'donor',
                       date_joined: '01/01/2022')
    @user = user
    @id = user.id
    @name = user.name
    @email = user.email
    @credits = user.credits
    @user_type = user.user_type
    @uin = user.uin
    OmniAuth.config.test_mode = true
    OmniAuth.config.add_mock(
      :google_oauth2,
      uid: user.id,
      info: { email: user.email }
    )
  end

  # not sure how relevant the code for credit pools is, we're never really doing anything with them directly accessed through routes...
  # a lot of this code will be cookie-cutter from the testing PA with regards to like create, update, delete, etc

  describe 'creates' do
    it 'credit pool normal' do
      session[:user_id] = @user.id
      post :create, params: { credit_pool: { credits: 1 } }
      expect(response).to have_http_status(:redirect)
      CreditPool.find_by(credits: 1).destroy
    end

    it 'credit pool bad' do
      CreditPool.create({ credits: 1 })
      session[:user_id] = @user.id
      post :create, params: { credit_pool: { test: 1 } }
    end
  end

  describe 'destroys' do
    it 'destroys normally' do
      pool = CreditPool.create({ credits: 1 })
      session[:user_id] = @user.id
      delete :destroy, params: { id: pool.id }
      expect(response).to have_http_status(:redirect)
    end
  end

  describe 'updates' do
    it 'graceful' do
      pool = CreditPool.create({ credits: 1 })
      session[:user_id] = @user.id
      patch :update, params: { id: pool.id, credit_pool: { credits: 2 } }

      expect(response).to have_http_status(:redirect)
    end

    it 'not graceful' do
      pool = CreditPool.create({ credits: 1 })
      session[:user_id] = @user.id
      patch :update, params: { id: pool.id, credit_pool: { credits: nil } }
    end
  end

  describe 'index' do
    it 'hits index' do
      session[:user_id] = @user.id
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'new' do
    it 'hits index' do
      session[:user_id] = @user.id
      get :new
      expect(response).to have_http_status(:success)
    end
  end
end
