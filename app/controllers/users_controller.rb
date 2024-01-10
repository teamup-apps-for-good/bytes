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

  private
  def new_user_params
    params.require(:user).permit(:uin, :credits, :user_type).merge(email: params[:email], name: params[:name], date_joined: Time.current, created_at: Time.current, updated_at: Time.current)
  end
end
