# frozen_string_literal: true

$user_request_limit = 10

require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  before(:each) do
    User.destroy_all
    CreditPool.destroy_all
    User.create({ name: 'Test', uin: '110011', email: 'test@tamu.edu', user_type: 'donor'})
    User.create({ name: 'John', uin: '123456', email: 'j@tamu.edu', user_type: 'donor'})
    User.create({ name: 'Todd', uin: '654321', email: 'todd@tamu.edu', user_type: 'recipient'})
    User.create({ name: 'Mark', uin: '324156', email: 'mark@tamu.edu', user_type: 'recipient'})
    User.create({ name: 'Kyle', uin: '987654', email: 'kyle@tamu.edu', user_type: 'recipient'})
    CreditPool.create(credits: 100)
  end

  let!(:user) { User.find_by(uin: '110011') }
  let!(:creditpool) { CreditPool.all[0] }

  describe 'when visiting the receive page' do
    before { session[:user_id] = user.id }

    it 'loads the page with the correct user' do
      get :receive, params: { id: user.id }
      expect(assigns(:user)).to eq(User.find_by(uin: user.uin))
    end

    it 'correctly loads the credit pool' do
      get :receive, params: { id: user.id }
      expect(assigns(:creditpool)).to eq(CreditPool.all[0])
    end
  end

  describe 'when requesting credits to receive' do
    before { session[:user_id] = User.find_by(uin: '110011').id }

    it 'warns the user if they ask for more credits than there are available' do
      get :do_receive, params: { num_credits: 200 }
      expect(flash[:warning]).to match(/Not enough credits available/)
    end

    it 'redirects back to receive credits page when unsuceesful' do
      get :do_receive, params: { num_credits: 200 }
      expect(response).to redirect_to(:user_receive)
    end

    it 'warns the user if they ask for more credits than the request limit allows' do
      get :do_receive, params: { num_credits: 11 }
      expect(flash[:warning]).to match(/Request too large, maximum allowed per request is #{$user_request_limit} credits/)
    end

    it 'redirects back to receive credits page when unsuceesful' do
      get :do_receive, params: { num_credits: 11 }
      expect(response).to redirect_to(:user_receive)
    end

    it 'redirects to the receive page when successful' do
      get :do_receive, params: { num_credits: 5 }
      expect(response).to redirect_to(:user_receive)
    end

    it 'notifies the user that credits have been transferred to their account' do
      get :do_receive, params: { num_credits: 5 }
      expect(flash[:notice]).to match(/CONFIRMATION Sucessfully recieved 5 credits!/)
    end

    it 'creates an instance of a Transaction to represent the exchange' do
      get :do_receive, params: { num_credits: 5 }
      expect(Transaction.all.where(uin: user.uin, transaction_type: 'received', amount: 5)).to exist
    end

    it 'trys to receive a negative number' do
      get :do_receive, params: { num_credits: -1 }
      expect(flash[:notice]).to match(/ERROR Invalid input!/)
    end
    
    it 'receives a error code from API' do
      get :do_receive, params: { num_credits: 1 }
      expect(flash[:warning]).to match(/Error updating credits. Status code: 4[0-9]{2}/)
    end

    # can't really test this one since its all mocked api calls with no real effect
    # it 'increases the number of credits a user has' do
    #   get :do_receive, params: { id: user.id, num_credits: 5 }
    #   expect(user.get_num_credits).to eq(55)
    # end

    it 'decreases the number of credits in the pool' do
      get :do_receive, params: { id: user.id, num_credits: 5 }
      expect(creditpool.reload.credits).to equal(95)
    end
  end

  describe 'when requesting credits when you have too many already' do
    before { session[:user_id] = User.find_by(uin: '987654').id }
    
    it 'does not allow user to make request if they have more credits than the request limit' do
      get :do_receive, params: { num_credits: 5 }
      expect(flash[:warning]).to match(/Must have less than #{$user_request_limit} credits in order to make a request/)
    end

    it 'redirects back to receive credits page when unsuceesful' do
      get :do_receive, params: { num_credits: 5 }
      expect(response).to redirect_to(:user_receive)
    end
  end

  describe 'account creation' do
    it 'successfully creates an account' do
      User.find_by(uin: '110011').destroy
      post :create, params: { user: { uin: '110011', user_type: 'donor' }},
                    session: { email: 'test@tamu.edu' }
      expect(flash[:notice]).to match(/Test Account's account was successfully created./)
      expect(response).to redirect_to '/users/profile'
    end

    it 'able to view account profile' do
      get :show, session: { user_id: User.find_by(uin: '123456').id }
      expect(response).to have_http_status(:success)
    end

    it 'fails to creates an account due to incorrect UIN' do
      post :create, params: { user: { uin: '-1', user_type: 'donor' }},
                    session: { email: 'test@tamu.edu' }
      expect(response).to redirect_to '/'
      expect(flash[:notice]).to match(/Error has occurred/)
    end

    it 'fails to creates an account due to too many credits as recipient' do
      post :create, params: { user: { uin: '654321', user_type: 'recipient' }},
                    session: { email: 'todd@tamu.edu' }
      expect(response).to redirect_to '/'
      expect(flash[:notice]).to match(/User has too many credits to create a receipent account/)
    end

    it 'fails to creates an account due to UIN and email mismatch' do
      post :create, params: { user: { uin: '123456', user_type: 'donor' }},
                    session: { email: 'test@tamu.edu' }
      expect(response).to redirect_to '/'
      expect(flash[:notice]).to match(/Email does not match the UIN/)
    end

    it 'fails to access profile without being logged in' do
      get :show, params: { id: 0 }, session: {}
      expect(response).to have_http_status(:redirect)
    end
  end
  describe 'transfer' do
    before { session[:user_id] = User.find_by(uin: '110011').id }

    it 'accesses transfer page successfully' do
      get :transfer, params: { id: user.id }
      expect(response).to have_http_status(:success)
    end

    it 'transfers successfully' do
      # normal happy path for transfer. we do it and expect a refresh for the flash message
      get :do_transfer, params: {credits: '5' }
      expect(response).to redirect_to :user_transfer
      expect(flash[:notice]).to match(/CONFIRMATION Sucessfully donated 5 credits to the pool!/)
    end

    it 'tries to transfer more than you have' do
      # sad path, we try to transfer more than we have
      get :do_transfer, params: {credits: '100' }
      expect(flash[:notice]).to eq('ERROR Trying to donate more credits than you have!')
    end

    it 'tries to transfer 0' do
      get :do_transfer, params: {credits: '0' }
      expect(flash[:notice]).to eq('ERROR Invalid input!')
    end

    it 'tries to transfer negative number' do # stealing !!!!
      get :do_transfer, params: {credits: '-1' }
      expect(flash[:notice]).to eq('ERROR Invalid input!')
    end

    it 'tries to transfer non-numeric input' do # stealing !!!!
      get :do_transfer, params: {credits: 'lololol' }
      expect(flash[:notice]).to eq('ERROR Invalid input!')
    end

    it 'receives a error code from API' do
      get :do_transfer, params: {credits: 1 }
      expect(flash[:warning]).to match(/Error updating credits. Status code: 4[0-9]{2}/)
    end
  end

  describe 'the user index page' do
    before { session[:user_id] = user.id }

    it 'it uses all users for rendering the page' do
      get :index
      expect(assigns[:users]).to eq(User.all)
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end
  end
end
