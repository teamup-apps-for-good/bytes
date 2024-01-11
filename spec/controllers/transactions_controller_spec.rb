require 'rails_helper'

RSpec.describe TransactionsController, type: :controller do
  before(:all) do
    Transaction.destroy_all

    Transaction.create(uin: "254007932",
                       transaction_type: "donated",
                       time: "2024-01-09T00:52:48",
                       amount: 3)

    Transaction.create(uin: "214003865",
                       transaction_type: "donated",
                       time: "2023-11-19T00:52:48",
                       amount: 1)

    Transaction.create(uin: "284007821",
                       transaction_type: "recieved",
                       time: "2024-01-01T00:52:48",
                       amount: 2)

    Transaction.create(uin: "231006398",
                       transaction_type: "donated",
                       time: "2024-01-01T00:52:48",
                       amount: 2)
  end

  describe 'when viewing a profile a user can see their transactions' do
    it 'returns valid transactions for the user' do
      user = User.create(name: 'John', uin: '254007932', email: 'j@tamu.edu', credits: '50', user_type: 'donor', date_joined: '01/01/2022')
      session[:user_id] = user.id
      get :index

      expect(assigns[:transactions]).to eq(Transaction.where(uin: user.uin))
    end
  end
end
