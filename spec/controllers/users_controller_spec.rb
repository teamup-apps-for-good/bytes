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
  end

  let!(:user) { User.find_by(uin: '1234')}

  describe 'when visiting the receive page' do
    it 'loads the page with the correct user' do
      get :user_receive, params: {id: user.id}
      expect(assigns(:user)).to eq(User.find_by(uin: user.uin))
    end

    it 'correctly loads the credit pool'
  end

  describe 'when requesting credits to receive' do
    it 'warns the user if they ask for more credits than there are available' do

    end

    it 'redirects to the user profile page when sucessful' do

    end

    it 'notifies the user that credits have been transferred to there account' do

    end

    it 'increases the number of credits a user has' do

    end

    it 'decreases the number of credits in the pool' do

    end
  end
end