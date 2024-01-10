class UsersController < ApplicationController
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

  def transfer

    #this is the controller for the actual transfer page
    #all we really want to do is set the global uin and user so we can use it later when we make our transfer call
    @user = User.find_by_uin(params[:uin])
    @uin = @user.uin

    puts "params #{params}"
    puts @uin

    if CreditPool.all.length > 1
      raise Exception.new "There are multiple pools... there shouldn't be"
    end
    @creditpool = CreditPool.all[0]

  end
  
  def do_transfer

    #grab who is doing the transfer, and how much
    credit_num = params[:credits].to_i #TODO needs to be string for sure
    uin = params[:uin]
    puts "params: #{params}"
    puts "uin #{params[:uin]} is sending #{params[:credits]} credits to the pool"
    @user = User.find_by_uin(uin)

    #now, subtract credits from their account
    @user.subtract_credits(credit_num)

    #create a transaction object
    transactionObject = Transaction.create({uin: @user.uin, transaction_type: "donor", time: "", amount: credit_num})

    #send the number of transfered credits to the pool TODO: DRY above in page_load (session maybe?)
    if CreditPool.all.length > 1
      raise Exception.new "There are multiple pools... there shouldn't be"
    end
    @creditpool = CreditPool.all[0]
    @creditpool.add_credits(credit_num)

    #notify user it's successful somehow
    flash[:notice] = "Sucessfully donated #{credit_num} credits to the pool!"
    redirect_to '/users' #not working..


  end
end
