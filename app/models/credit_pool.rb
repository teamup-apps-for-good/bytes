class CreditPool < ApplicationRecord

    def add_credits(amt)

        self.update(credits: self.credits + amt)

    end

    def subtract(amt)
      if (amt > self.credits)
        raise Exception.new "Not enough credits to subtract this amount"
      end 
      
      self.update(credits: self.credits - amt)
    end
end
