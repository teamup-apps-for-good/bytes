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
    @curr_user = User.find(session["uin"])
    @amount = params[:num_credits]
    
    # NOTE: Pool.quantity not implemented yet
    if @amount > Pool.quantity
      flash[:warning] = "Not enough credits available, only #{Pool.quantity} credits currently available"
      return -1   # keep user on same page so they can quickly change again
    end

    Transaction.new(:amount => @amount, :type => 'Receive')
    @curr_user.add_credits(@amount)
    flash[:notice] = "#{@amount} Credits received"
    redirect_to profile_path
  end
end
