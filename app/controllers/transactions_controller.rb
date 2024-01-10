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
end
