require 'rails_helper'

RSpec.describe PagesController, type: :controller do
    describe 'index' do
        it 'hits index' do
            get :index
            expect(response).to have_http_status(:success)
        end
    end
end