require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  before do
    User.destroy_all

    User.create(uin: '1234',
                name: 'John Smith',
                email: 'JS@tamu.edu',
                credits: 50,
                user_type: 'recipient',
                date_joined: 1977-02-23
    )

    CreditPool.create(credits: 100)
  end

  let!(:user) { User.find_by(uin: '1234') }
  let!(:login) { session[:user_id] = user.id }
  let!(:creditpool) { CreditPool.all[0] }

  describe 'when visiting the receive page' do
    before {session[:user_id] = user.id}

    it 'loads the page with the correct user' do
      get :receive, params: {id: user.id}
      expect(assigns(:user)).to eq(User.find_by(uin: user.uin))
    end

    it 'correctly loads the credit pool' do
      get :receive, params: {id: user.id}
      expect(assigns(:creditpool)).to eq(CreditPool.all[0])
    end
  end

  describe 'when requesting credits to receive' do
    before {session[:user_id] = user.id}

    it 'warns the user if they ask for more credits than there are available' do
      get :do_receive, params: {id: user.id, num_credits: 200}
      expect(flash[:warning]).to match(/Not enough credits available, only #{creditpool.credits} credits currently in pool/)
    end

    it 'redirects back to receive credits page when unsuceesful' do
      get :do_receive, params: {id: user.id, num_credits: 200}
      expect(response).to redirect_to("/users/#{user.id}/receive")
    end

    it 'redirects to the user profile page when sucessful' do
      get :do_receive, params: {id: user.id, num_credits: 5}
      expect(response).to redirect_to("/users/#{user.id}")
    end

    it 'notifies the user that credits have been transferred to there account' do
      get :do_receive, params: {id: user.id, num_credits: 5}
      expect(flash[:notice]).to match(/5 Credits received/)
    end

    it 'creates an instance of a Transaction to represent the exchange' do
      get :do_receive, params: {id: user.id, num_credits: 5}
      expect(Transaction.all.where(uin: user.uin, transaction_type: 'received', amount: 5)).to exist
    end

    it 'increases the number of credits a user has' do
      get :do_receive, params: {id: user.id, num_credits: 5}
      expect(user.reload.credits).to eq(55)
    end

    it 'decreases the number of credits in the pool' do
      get :do_receive, params: {id: user.id, num_credits: 5}
      expect(creditpool.reload.credits).to equal(95)
    end
  end
end