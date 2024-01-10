class CreditPool < ApplicationRecord

    def add_credits(amt)

        self.update(credits: self.credits + amt)

    end
end
