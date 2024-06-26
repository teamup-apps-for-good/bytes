# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PagesController do
  before(:all) do
    User.destroy_all
    User.create(uid: '1234',
                name: 'John Smith',
                email: 'JS@tamu.edu',
                credits: 50,
                user_type: 'recipient',
                date_joined: 1977 - 0o2 - 23)
    User.create(name: 'John',
                uid: '123456',
                email: 'j@tamu.edu',
                credits: 50,
                user_type: 'donor',
                date_joined: '01/01/2022')
  end

  describe 'index' do
    it 'hits index' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'while logged in' do
      get :index, session: { user_id: User.find_by(uid: '1234').id }
      expect(response).to redirect_to('/users/profile')
    end

    it 'sees metric-strings' do
      30.times do # needs to be a better way, but for now will get good coverage with enough runs
        get :index
        expect(response).to have_http_status(:success)
        # Add expectations for the output of each random function
        expect(assigns(:metric_string)).not_to be_nil
      end
    end
  end
end
