require 'rails_helper'

RSpec.describe UsersController, type: :controller do
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
