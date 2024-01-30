# frozen_string_literal: true

# controller class for Users
class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new; end

  def show
    @user = User.find(session[:user_id])
  end

  def create
    @user = User.create!(new_user_params)
    flash[:notice] = %(#{@user.name}'s account was successfully created.)
    session[:user_id] = @user.id
    session[:creating] = false
    redirect_to '/users/profile'
  rescue StandardError
    flash[:notice] = 'Error has occurred'
    redirect_to '/', alert: 'Login failed.'
  end

  def edit; end

  def update; end

  def search; end

  def transfer
    # this is the controller for the actual transfer page
    # all we really want to do is set the global uin and user so we can use it later when we make our transfer call
    @user = User.find_by_id(session[:user_id])

    # puts "params #{params}"
    # puts @user.name

    raise StandardError, "There are multiple pools... there shouldn't be" if CreditPool.all.length > 1

    @creditpool = CreditPool.all[0]
    # puts "credit pool: #{@creditpool}"
  end

  def do_transfer
    # puts "INITIATING TRANSFER!"
    # grab who is doing the transfer, and how much

    unless params[:credits].to_i.to_s == params[:credits]
      flash[:notice] = 'ERROR Invalid input!'
      redirect_to :user_transfer
      return
    end
    credit_num = params[:credits].to_i
    id = session[:user_id]
    # puts "params: #{params}"
    # puts "uin #{params[:id]} is sending #{params[:credits]} credits to the pool"
    @user = User.find_by_id(id)

    # check to see if there are any errors with credit amount
    if credit_num > @user.credits
      flash[:notice] = 'ERROR Trying to donate more credits than you have!'
      redirect_to :user_transfer
      return

    end

    if credit_num.zero? || credit_num.negative?
      flash[:notice] = 'ERROR Invalid input!'
      redirect_to :user_transfer
      return
    end

    # now, subtract credits from their account
    response_code = @user.subtract_credits(credit_num)

    # FIXME HANDLE BAD RESPONSE CODES 

    # create a transaction object
    Transaction.create({ uin: @user.uin, transaction_type: 'donor', time: '', amount: credit_num })

    # send the number of transfered credits to the pool TODO: DRY above in page_load (session maybe?)
    raise StandardError, "There are multiple pools... there shouldn't be" if CreditPool.all.length > 1

    @creditpool = CreditPool.all[0]
    @creditpool.add_credits(credit_num)

    # notify user it's successful somehow
    flash[:notice] = "CONFIRMATION Sucessfully donated #{credit_num} credits to the pool!"
    redirect_to :user_transfer
  end

  def receive
    @user = User.find_by(id: session[:user_id])
    @uin = @user.uin

    raise StandardError, "There are multiple pools... there shouldn't be" if CreditPool.all.length > 1

    @creditpool = CreditPool.all[0]
  end

  def do_receive
    @user = User.find_by(id: session[:user_id])
    num_credits = params[:num_credits].to_i

    # handles invalid number of credits 
    if num_credits <= 0
      flash[:notice] = 'ERROR Invalid input!'
      redirect_to :user_receive
      return
    end

    @creditpool = CreditPool.all[0]
    # handles there not being enough credits for the request
    if num_credits > @creditpool.credits
      flash[:warning] = "Not enough credits available, only #{@creditpool.credits} credits currently in pool"
      redirect_to :user_receive
      return -1
    end

    response_code = @user.add_credits(num_credits)

    # FIXME HANDLE BAD RESPONSE CODES
    
    @creditpool.subtract_credits(num_credits)
    Transaction.create({ uin: @user.uin, transaction_type: 'received', time: '', amount: num_credits})
    flash[:notice] = "#{num_credits} Credits received"
    redirect_to '/users/profile'
  end

  private

  def new_user_params
    params.require(:user).permit(:uin, :credits, :user_type).merge(params.permit(:name, :email)).merge(
      date_joined: Time.current, created_at: Time.current, updated_at: Time.current
    )
  end
end
