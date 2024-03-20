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

    context 'when meeting is not found' do
      it 'redirects with error notice' do
        user = User.create(name: 'John', uid: '254007932', email: 'j@tamu.edu', credits: '50', user_type: 'donor', date_joined: '01/01/2022')
        session[:user_id] = user.id
        meeting = Meeting.create(date: '2024-03-11', time: '12:00 PM', location: 'Conference Room', uid: user.id)

        allow_any_instance_of(Meeting).to receive(:destroy).and_return(false)

        delete :destroy, params: { id: meeting.id }

        expect(flash[:notice]).to eq('Error: Meeting not deleted.')
      end

      it 'logs a message and redirects with error notice' do
        user = User.create(name: 'John', uid: '254007932', email: 'j@tamu.edu', credits: '50', user_type: 'donor', date_joined: '01/01/2022')
        session[:user_id] = user.id

        allow(Meeting).to receive(:find_by).and_return(nil)

        delete :destroy, params: { id: 999 }

        expect(flash[:notice]).to eq('Error: Meeting not found.')
      end
    end
  end

  describe 'POST accept_meeting' do
    it 'accepts the meeting' do
      user = User.create(name: 'John', uid: '254007932', email: 'j@tamu.edu', credits: '7', user_type: 'recipient',
                  date_joined: '01/01/2022')
      session[:user_id] = user.id
      meeting = Meeting.create(uid: '123456789', date: '2024-03-11', time: '12:00 PM', location: 'Conference Room', accepted: false, accepted_uid: nil)
      post :accept_meeting, params: { id: meeting.id }
      expect(Meeting.where(accepted: true).count).to eq(1)
    end
    it 'redirects to the meetings index' do
      user = User.create(name: 'John', uid: '254007932', email: 'j@tamu.edu', credits: '7', user_type: 'recipient',
                  date_joined: '01/01/2022')
      session[:user_id] = user.id
      meeting = Meeting.create(uid: '123456789', date: '2024-03-11', time: '12:00 PM', location: 'Conference Room', accepted: false, accepted_uid: nil)
      post :accept_meeting, params: { id: meeting.id }
      expect(response).to redirect_to(meetings_path)
    end
  end

  describe 'POST unaccept_meeting' do
    it 'unaccepts the meeting' do
      user = User.create(name: 'John', uid: '254007932', email: 'j@tamu.edu', credits: '7', user_type: 'recipient',
                  date_joined: '01/01/2022')
      session[:user_id] = user.id
      meeting = Meeting.create(uid: '123456789', date: '2024-03-11', time: '12:00 PM', location: 'Conference Room', accepted: true, accepted_uid: '254007932')
      post :unaccept_meeting, params: { id: meeting.id }
      expect(Meeting.where(accepted: true).count).to eq(0)
    end
    it 'redirects to the meetings index' do
      user = User.create(name: 'John', uid: '254007932', email: 'j@tamu.edu', credits: '7', user_type: 'recipient',
                  date_joined: '01/01/2022')
      session[:user_id] = user.id
      meeting = Meeting.create(uid: '123456789', date: '2024-03-11', time: '12:00 PM', location: 'Conference Room', accepted: true, accepted_uid: '254007932')
      post :unaccept_meeting, params: { id: meeting.id }
      expect(response).to redirect_to(meetings_path)
    end
  end

  describe '#get_next_week(id)' do
    it 'returns the date of a week after a given meeting' do
      user = User.create(name: 'John', uid: '254007932', email: 'j@tamu.edu', credits: '7', user_type: 'recipient',
      date_joined: '01/01/2022')
      session[:user_id] = user.id
      meeting = Meeting.create(uid: '123456789', date: '2024-03-11', time: '12:00 PM', location: 'Conference Room', accepted: true, accepted_uid: '254007932', recurring: true)
      expected_date_string = (meeting.date + 7.days)
      expect(controller.get_next_week(meeting.id)).to eq(expected_date_string)
    end
  end

  describe 'POST donor_cancel' do
    context 'recurring meeting' do
      it 'resets accepted' do
        user = User.create(name: 'John', uid: '254007932', email: 'j@tamu.edu', credits: '50', user_type: 'donor',
                  date_joined: '01/01/2022')
        session[:user_id] = user.id
        meeting = Meeting.create(uid: '254007932', date: '2024-03-11', time: '12:00 PM', location: 'Conference Room', accepted: true, accepted_uid: '123456789', recurring: true)
        post :donor_cancel, params: {id: meeting.id}
        expect(Meeting.find_by(id: meeting.id).accepted).to eq(false)
        expect(Meeting.find_by(id: meeting.id).accepted_uid).to eq(nil)
      end
      it 'redirects to meeting index' do
        user = User.create(name: 'John', uid: '254007932', email: 'j@tamu.edu', credits: '50', user_type: 'donor',
                  date_joined: '01/01/2022')
        session[:user_id] = user.id
        meeting = Meeting.create(uid: '254007932', date: '2024-03-11', time: '12:00 PM', location: 'Conference Room', accepted: true, accepted_uid: '123456789', recurring: true)
        post :donor_cancel, params: {id: meeting.id}
        expect(response).to redirect_to(meetings_path)
      end
    end
    context 'non-recurring meeting' do
      it 'destroys the meeting' do
        user = User.create(name: 'John', uid: '254007932', email: 'j@tamu.edu', credits: '50', user_type: 'donor',
                  date_joined: '01/01/2022')
        session[:user_id] = user.id
        meeting = Meeting.create(uid: '254007932', date: '2024-03-11', time: '12:00 PM', location: 'Conference Room', accepted: true, accepted_uid: '123456789', recurring: false)
        post :donor_cancel, params: {id: meeting.id}
        expect(Meeting.count).to eq(0)
      end
      it 'redirects to meetings index' do
        user = User.create(name: 'John', uid: '254007932', email: 'j@tamu.edu', credits: '50', user_type: 'donor',
                  date_joined: '01/01/2022')
        session[:user_id] = user.id
        meeting = Meeting.create(uid: '254007932', date: '2024-03-11', time: '12:00 PM', location: 'Conference Room', accepted: true, accepted_uid: '123456789', recurring: false)
        post :donor_cancel, params: {id: meeting.id}
        expect(response).to redirect_to(meetings_path)
      end
      it 'flashes cancel message' do
        user = User.create(name: 'John', uid: '254007932', email: 'j@tamu.edu', credits: '50', user_type: 'donor',
                  date_joined: '01/01/2022')
        session[:user_id] = user.id
        meeting = Meeting.create(uid: '254007932', date: '2024-03-11', time: '12:00 PM', location: 'Conference Room', accepted: true, accepted_uid: '123456789', recurring: false)
        post :donor_cancel, params: {id: meeting.id}
        expect(flash[:notice]).to eq('Meeting cancelled.')
      end
    end
  end

  describe 'POST complete_transaction' do
    context 'recurring meeting' do
      it 'resets accepted' do
        user = User.create(name: 'John', uid: '254007932', email: 'j@tamu.edu', credits: '7', user_type: 'recipient',
                  date_joined: '01/01/2022')
        session[:user_id] = user.id
        meeting = Meeting.create(uid: '123456789', date: '2024-03-11', time: '12:00 PM', location: 'Conference Room', accepted: true, accepted_uid: '254007932', recurring: true)
        post :complete_transaction, params: {id: meeting.id}
        expect(Meeting.find_by(id: meeting.id).accepted).to eq(false)
        expect(Meeting.find_by(id: meeting.id).accepted_uid).to eq(nil)
      end
      it 'redirects to meeting index' do
        user = User.create(name: 'John', uid: '254007932', email: 'j@tamu.edu', credits: '7', user_type: 'recipient',
                  date_joined: '01/01/2022')
        session[:user_id] = user.id
        meeting = Meeting.create(uid: '123456789', date: '2024-03-11', time: '12:00 PM', location: 'Conference Room', accepted: true, accepted_uid: '254007932', recurring: true)
        post :complete_transaction, params: {id: meeting.id}
        expect(response).to redirect_to(meetings_path)
      end
    end
    context 'non-recurring meeting' do
      it 'destroys the meeting' do
        user = User.create(name: 'John', uid: '254007932', email: 'j@tamu.edu', credits: '7', user_type: 'recipient',
                  date_joined: '01/01/2022')
        session[:user_id] = user.id
        meeting = Meeting.create(uid: '123456789', date: '2024-03-11', time: '12:00 PM', location: 'Conference Room', accepted: true, accepted_uid: '254007932')
        post :complete_transaction, params: {id: meeting.id}
        expect(Meeting.count).to eq(0)
      end
      it 'redirects to meetings index' do
        user = User.create(name: 'John', uid: '254007932', email: 'j@tamu.edu', credits: '7', user_type: 'recipient',
                  date_joined: '01/01/2022')
        session[:user_id] = user.id
        meeting = Meeting.create(uid: '123456789', date: '2024-03-11', time: '12:00 PM', location: 'Conference Room', accepted: true, accepted_uid: '254007932')
        post :complete_transaction, params: {id: meeting.id}
        expect(response).to redirect_to(meetings_path)
      end
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
