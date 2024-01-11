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

    CreditPool.destroy_all
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

    it 'notifies the user that credits have been transferred to their account' do
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

  before(:all) do
    User.destroy_all
    CreditPool.destroy_all
    User.create({name: "John", uin: "123456", email: "j@tamu.edu", credits: 50, user_type:"donor", date_joined: "01/01/2022"})
    User.create({name: "Todd", uin: "654321", email: "todd@tamu.edu", credits: 100, user_type:"donor", date_joined: "01/01/2022"})
    User.create({name: "Mark", uin: "324156", email: "mark@tamu.edu", credits: 3, user_type:"recipient", date_joined: "01/01/2022"})
    CreditPool.create({credits: 1})
    
  end

  describe 'transfer' do


    it 'accesses transfer page successfully' do
        user = User.create({name: "Jim", uin: "800813", email: "jim@tamu.edu", credits: 1, user_type:"donor", date_joined: "01/01/2022"})
        session[:user_id] = user.id
        get :transfer, params: {id: user.id}
        expect(response).to have_http_status(:success)
    end
    it 'transfers successfully' do

        #normal happy path for transfer. we do it and expect a refresh for the flash message
        user = User.create({name: "Jim", uin: "800813", email: "jim@tamu.edu", credits: 100, user_type:"donor", date_joined: "01/01/2022"})
        session[:user_id] = user.id
        get :do_transfer, params: {id: user.id, credits: '1'}
        expect(response).to have_http_status(:redirect)
      
    end

    it 'tries to transfer more than you have' do
        #sad path, we try to transfer more than we have
        user = User.create({name: "Jim", uin: "800813", email: "jim@tamu.edu", credits: 0, user_type:"donor", date_joined: "01/01/2022"})
        session[:user_id] = user.id
        get :do_transfer, params: {id: user.id, credits: '1'}

        expect(flash[:notice]).to eq("ERROR Trying to donate more credits than you have!")
    end

    it 'tries to transfer 0' do 
        user = User.create({name: "Jim", uin: "800813", email: "jim@tamu.edu", credits: 1, user_type:"donor", date_joined: "01/01/2022"})
        session[:user_id] = user.id
        get :do_transfer, params: {id: user.id, credits: '0'}
        expect(flash[:notice]).to eq("ERROR Invalid input!")

    end

    it 'tries to transfer negative number' do  #stealing !!!!
        user = User.create({name: "Jim", uin: "800813", email: "jim@tamu.edu", credits: 1, user_type:"donor", date_joined: "01/01/2022"})
        session[:user_id] = user.id
        get :do_transfer, params: {id: user.id, credits: '-1'}
        expect(flash[:notice]).to eq("ERROR Invalid input!")

    end

    it 'tries to transfer non-numeric input' do  #stealing !!!!
        user = User.create({name: "Jim", uin: "800813", email: "jim@tamu.edu", credits: 1, user_type:"donor", date_joined: "01/01/2022"})
        session[:user_id] = user.id
        res = get :do_transfer, params: {id: user.id, credits: 'lololol'}
        expect(flash[:notice]).to eq("ERROR Invalid input!")

    end
  end
end
