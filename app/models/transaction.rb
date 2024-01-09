class Transaction < ApplicationRecord
  def initialize amount, type
    @uin = session["uin"]
    @amount = amount
    @type = type
    @timestamp = Time.now # NOTE: may need to reformat time later
  end
end
