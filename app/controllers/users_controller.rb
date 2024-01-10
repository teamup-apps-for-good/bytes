class UsersController < ApplicationController
  def index
  end

  def new
  end

  def show
    @current_user = User.find(params[:id])
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

    #set the global uin so we can use it later
    @user = User.find_by_uin(params[:uin])
    @uin = @user.uin

    puts "params #{params}"
    puts @uin

  end
  def do_transfer

    #grab who is doing the transfer, and how much
    credit_num = params[:credits].to_i #TODO needs to be string for sure
    uin = params[:uin]

    puts "params: #{params}"
    puts "uin #{params[:uin]} is sending #{params[:credits]} credits to the pool"

    @user = User.find_by_uin(uin)

    @user.subtract_credits(credit_num)

  end
end
