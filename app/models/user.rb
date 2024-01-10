class User < ApplicationRecord
    validates :uin, :name, :email, :credits, presence: true
    validates :credits, numericality: { only_integer: true }

    def subtract_credits(amount)
        puts "before update: #{self.credits}"
        self.update({credits: self.credits-amount})
        puts "after update: #{self.credits}"
    end

    def add_credits(amount)
        puts "before update: #{self.credits}"
        self.update({credits: self.credits-amount})
        puts "after update: #{self.credits}"
    end
end
