# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  before(:all) do
    described_class.destroy_all
    described_class.create({ name: 'John', uin: '123456', email: 'j@tamu.edu', user_type: 'donor'})
  end

  # Can't really test this since credits are now stored within the external API
  # describe 'subtract method' do
  #   it 'successfully subtracts credits' do
  #     user = described_class.create(name: 'Tim', uin: '239404', email: 't@tamu.edu', user_type: 'donor')
  #     credits_before = user.credits
  #     user.subtract_credits(1)
  #     credits_after = user.credits
  #     expect(credits_before).to eq(credits_after + 1)
  #   end

  #   it 'successfully adds credits' do
  #     user = described_class.create(name: 'Tim', uin: '239404', email: 't@tamu.edu', user_type: 'donor')
  #     credits_before = user.credits
  #     user.add_credits(1)
  #     credits_after = user.credits
  #     expect(credits_before).to eq(credits_after - 1)
  #   end
  # end
end
