class TransactionsController < ApplicationController
  def index
  end

  def new
  end

  def show
  end

  def create
  end

  def edit
  end

  def update
  end

  def search
  end

  def receive
    # @user = User.find_by_uin(params[:uin])
    # @uin = @user.uin

    if CreditPool.all.length > 1
      raise Exception.new "There are multiple pools... there shouldn't be"
    end
    @creditpool = CreditPool.all[0]
    puts @creditpool
  end

  def do_receive
    # @curr_user = User.find(session["uin"])
    amount = params[:num_credits].to_i
    
    @creditpool = CreditPool.all[0]
    # handles there not being enough credits for the request
    if amount > @creditpool.credits
      flash[:warning] = "Not enough credits available, only #{@creditpool.credits} credits currently in pool"
      redirect_to :transaction_receive
      return -1
    end

    # FIXME: REPLACE UIN WITH ACTUAL UIN ONCE USer IS AVAILABLE
    new_transaction = Transaction.create({uin: 123456, transaction_type: "recipient", time: "", amount: amount})
    @creditpool.subtract_credits amount
    # @curr_user.add_credits amount
    flash[:notice] = "#{amount} Credits received"
    redirect_to :transaction_receive
  end

  def add_to_pool

    puts "params #{params}"
    credits_to_add = params[:credits]

  end
end
