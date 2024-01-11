class User < ApplicationRecord
    validates :uin, :name, :email, :credits, presence: true
    validates :credits, numericality: { only_integer: true }

    def subtract_credits(amount)
        # do the actual subtraction update in the database
        puts "before update: #{self.credits}"
        self.update({credits: self.credits-amount})
        puts "after update: #{self.credits}"
    end

    def add_credits(amount)
        # do the actual addition update in the database
        #puts "before update: #{self.credits}"
        self.update({credits: self.credits+amount})
        #puts "after update: #{self.credits}"
    end
end
