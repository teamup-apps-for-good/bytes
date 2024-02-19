# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TransactionsController do
  before(:all) do
    Transaction.destroy_all
    User.destroy_all
    CreditPool.destroy_all

    Transaction.create(uid: '254007932',
                       transaction_type: 'donated',
                       time: '2024-01-09T00:52:48',
                       amount: 3)

    Transaction.create(uid: '214003865',
                       transaction_type: 'donated',
                       time: '2023-11-19T00:52:48',
                       amount: 1)

    Transaction.create(uid: '284007821',
                       transaction_type: 'recieved',
                       time: '2024-01-01T00:52:48',
                       amount: 2)

    Transaction.create(uid: '231006398',
                       transaction_type: 'donated',
                       time: '2024-01-01T00:52:48',
                       amount: 2)
                       
    CreditPool.create({ school_name: 'TAMU', email_suffix: 'tamu.edu', id_name: 'UIN', credits: 1})
  end

  describe 'when viewing a profile a user can see their transactions' do
    it 'returns valid transactions for the user' do
      user = User.create(name: 'John', uid: '254007932', email: 'j@tamu.edu', credits: '50', user_type: 'donor',
                         date_joined: '01/01/2022')
      session[:user_id] = user.id
      get :index

      expect(assigns[:transactions]).to eq(Transaction.where(uid: user.uid))
    end

    it 'does not return transactions by other users' do
      user = User.create(name: 'John', uid: '254007932', email: 'j@tamu.edu', credits: '50', user_type: 'donor',
                         date_joined: '01/01/2022')
      session[:user_id] = user.id
      get :index
      expect(assigns[:transactions]).not_to eq(Transaction.where(uid: '254009768'))
    end
  end

  describe 'shows correct transaction' do
    it 'returns the correct transaction' do
      user = User.create(name: 'John', uid: '254007932', email: 'j@tamu.edu', credits: '50', user_type: 'donor',
                         date_joined: '01/01/2022')
      session[:user_id] = user.id
      transaction = Transaction.create(uid: '254007932',
                                       transaction_type: 'donated',
                                       time: '2024-01-09T00:52:48',
                                       amount: 3)
      get :show, params: { id: transaction.id }
      expect(assigns[:transaction]).to eq(transaction)
    end
  end
end
