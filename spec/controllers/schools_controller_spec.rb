# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SchoolsController do
  before(:all) do
    School.destroy_all
    User.destroy_all

    School.create({name: 'Texas A&M University',
                  domain: 'tamu.edu',
                  logo: 'tamu-logo-words.png'})

    School.create({name: 'University of Houston',
                  domain: 'uh.edu',
                  logo: 'background.png'})

    School.create({name: 'Rice University',
                  domain: 'ru.edu',
                  logo: 'background2.png'})
  end

  describe 'when requesting all schools the data is returned' do
    it 'returns all schools' do
      user = User.create(name: 'John', uin: '254007932', email: 'j@tamu.edu', credits: '50', user_type: 'donor',
                  date_joined: '01/01/2022')
      session[:user_id] = user.id

      get :index
      expect(assigns[:schools]).to eq(School.all)
    end

    it 'renders the index template' do
      user = User.create(name: 'John', uin: '254007932', email: 'j@tamu.edu', credits: '50', user_type: 'donor',
                  date_joined: '01/01/2022')
      session[:user_id] = user.id

      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'when logging in the user can see the correct data for their school' do
    it 'returns the correct school' do
      user = User.create(name: 'John', uin: '254007932', email: 'j@tamu.edu', credits: '50', user_type: 'donor',
                  date_joined: '01/01/2022')
      session[:user_id] = user.id
      school = School.create(name: 'Oklahoma State University',
                             domain: 'osu.edu',
                             logo: 'background3.png')
      get :show, params: { id: school.id }
      expect(assigns[:school]).to eq(school)
    end

    it 'does not return an unexpected school' do
      user = User.create(name: 'John', uin: '254007932', email: 'j@tamu.edu', credits: '50', user_type: 'donor',
                  date_joined: '01/01/2022')
      session[:user_id] = user.id
      school = School.create(name: 'Oklahoma State University',
                             domain: 'osu.edu',
                             logo: 'background3.png')

      get :show, params: { id: school.id }
      expect(assigns[:school]).not_to eq(School.where(name: 'Texas A&M University'))
    end
  end
end
