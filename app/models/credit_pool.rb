# frozen_string_literal: true

# class that represents the pool of donated credits available
class CreditPool < ApplicationRecord
  def add_credits(amt)
    update(credits: credits + amt)
  end

  def subtract_credits(amt)
    raise StandardError, 'Not enough credits to subtract this amount' if amt > credits

    update(credits: credits - amt)
  end
end
