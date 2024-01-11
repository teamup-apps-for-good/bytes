# frozen_string_literal: true

# class that represents the pool of donated credits available
class CreditPool < ApplicationRecord
  validates :credits, presence: true
  
  def add_credits(amt)

      self.update(credits: self.credits + amt)

  end

  def subtract_credits(amt)
    if (amt > self.credits)
      raise Exception.new "Not enough credits to subtract this amount"
    end 
    
    self.update(credits: self.credits - amt)
  end
end
