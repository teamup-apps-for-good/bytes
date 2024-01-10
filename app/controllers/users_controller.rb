class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
  end

  def show
    @user = User.find(session[:user_id])
  end

  def create
    begin
      @user = User.create!(new_user_params)
      flash[:notice] = "#{@user.name}'s account was successfully created."
      session[:user_id] = @user.id
      redirect_to user_path(@user), notice: 'You are logged in.'
    rescue
      flash[:notice] = "Error has occurred"
      redirect_to '/', alert: 'Login failed.'
    end
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

    puts "credit pool: #{@creditpool}"

  end
  
  def do_transfer

    #grab who is doing the transfer, and how much
    credit_num = params[:credits].to_i #TODO needs to be string for sure
    uin = params[:uin]
    puts "params: #{params}"
    puts "uin #{params[:uin]} is sending #{params[:credits]} credits to the pool"
    @user = User.find_by_uin(uin)


    #check to see if there are any errors with credit amount
    if credit_num > @user.credits
      flash[:notice] = "ERROR Trying to donate more credits than you have!"
      redirect_to "/users/#{@user.uin}/transfer" #messy..
      return

    end

    if credit_num == 0 || credit_num == ""
      flash[:notice] = "ERROR input invalid!"
      redirect_to "/users/#{@user.uin}/transfer" #messy..
      return
    end
    
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
    flash[:notice] = "CONFIRMATION Sucessfully donated #{credit_num} credits to the pool!"
    redirect_to "/users/#{@user.uin}/transfer" #messy..


  end

  private
  def new_user_params
    params.require(:user).permit(:uin, :credits, :user_type).merge(email: params[:email], name: params[:name], date_joined: Time.current, created_at: Time.current, updated_at: Time.current)
  end
  
  def get_profile
    @user = User.find_by_uin(params[:uin])
    @uin = @user.uin
    @credits = @user.credits
    @email = @user.email
    @user_type = @user.user_type
  end
end
