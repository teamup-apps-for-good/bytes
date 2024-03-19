require 'rails_helper'
RSpec.describe MeetingsController, type: :controller do
  before(:all) do
    User.destroy_all
  end

  describe 'GET index' do
    it 'renders the index template' do
      user = User.create(name: 'John', uid: '254007932', email: 'j@tamu.edu', credits: '50', user_type: 'donor',
                  date_joined: '01/01/2022')
      session[:user_id] = user.id
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET new' do
    it 'renders the new template' do
      user = User.create(name: 'John', uid: '254007932', email: 'j@tamu.edu', credits: '50', user_type: 'donor',
                  date_joined: '01/01/2022')
      session[:user_id] = user.id
      get :new
      expect(response).to render_template('new')
    end
  end

  describe 'DELETE destroy' do
    it 'destroys the requested meeting' do
      user = User.create(name: 'John', uid: '254007932', email: 'j@tamu.edu', credits: '50', user_type: 'donor', date_joined: '01/01/2022')
      meeting = Meeting.create(date: '2024-03-11', time: '12:00 PM', location: 'Conference Room', uid: user.id)
  
      session[:user_id] = user.id
      puts "MEETING ID: " + meeting.id.to_s
      delete :destroy, params: {id: meeting.id}
      expect(Meeting.count).to eq(0)
    end
  
    it 'redirects to the meetings index' do
      user = User.create(name: 'John', uid: '254007932', email: 'j@tamu.edu', credits: '50', user_type: 'donor', date_joined: '01/01/2022')
      meeting = Meeting.create(date: '2024-03-11', time: '12:00 PM', location: 'Conference Room', uid: user.id)
  
      session[:user_id] = user.id
  
      delete :destroy, params: { id: meeting.id }
  
      expect(response).to redirect_to(meetings_path)
    end
  end


  describe 'POST create' do
    context 'with valid parameters' do
      it 'creates a new meeting' do
        user = User.create(name: 'John', uid: '254007932', email: 'j@tamu.edu', credits: '50', user_type: 'donor',
                  date_joined: '01/01/2022')
        session[:user_id] = user.id
        post :create, params: { meeting: { date: '2024-03-11', time: '12:00 PM', location: 'Conference Room' } }
        expect(Meeting.count).to eq(1)
      end

      it 'redirects to the meetings index' do
        user = User.create(name: 'John', uid: '254007932', email: 'j@tamu.edu', credits: '50', user_type: 'donor',
                  date_joined: '01/01/2022')
        session[:user_id] = user.id
        post :create, params: { meeting: { date: '2024-03-11', time: '12:00 PM', location: 'Conference Room' } }
        expect(response).to redirect_to(meetings_path)
      end
    end
    
    context 'without valid parameters' do
        it 'does not redirect with no location' do
            user = User.create(name: 'John', uid: '254007932', email: 'j@tamu.edu', credits: '50', user_type: 'donor',
                        date_joined: '01/01/2022')
            session[:user_id] = user.id
            post :create, params: { meeting: { date: '2024-03-11', time: '12:00 PM'} }
            expect(response).to have_http_status(200)
        end

        it 'does not redirect with no date' do
            user = User.create(name: 'John', uid: '254007932', email: 'j@tamu.edu', credits: '50', user_type: 'donor',
                        date_joined: '01/01/2022')
            session[:user_id] = user.id
            post :create, params: { meeting: { time: '12:00 PM', location: 'Conference Room' } }
            expect(response).to have_http_status(200)
        end

        it 'does not redirect with no time' do
            user = User.create(name: 'John', uid: '254007932', email: 'j@tamu.edu', credits: '50', user_type: 'donor',
                        date_joined: '01/01/2022')
            session[:user_id] = user.id
            post :create, params: { meeting: { date: '2024-03-11', location: 'Conference Room' } }
            expect(response).to have_http_status(200)
        end
    end
  end
end