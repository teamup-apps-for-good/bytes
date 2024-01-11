require 'rails_helper'

RSpec.describe User, type: :model do
    before(:all) do
        if described_class.where(uin: '123456').empty?
            described_class.create({name: "John", uin: "123456", email: "j@tamu.edu", credits: 50, user_type:"donor", date_joined: "01/01/2022"})
        end
    end

    describe 'subtract method' do

        it 'successfully subtracts credits' do
            user = described_class.create(name: "Tim", uin: "239404", email: "t@tamu.edu", credits: 50, user_type:"donor", date_joined: "01/01/2022")
            credits_before = user.credits
            user.subtract_credits(1)
            credits_after = user.credits
            expect(credits_before).to eq(credits_after + 1)
        end

        it 'successfully adds credits' do
            user = described_class.create(name: "Tim", uin: "239404", email: "t@tamu.edu", credits: 50, user_type:"donor", date_joined: "01/01/2022")
            credits_before = user.credits
            user.add_credits(1)
            credits_after = user.credits
            expect(credits_before).to eq(credits_after - 1)
        end
    end

end
