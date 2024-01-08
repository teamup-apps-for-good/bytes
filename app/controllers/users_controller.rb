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

    #set the global uin so we can use it later
    @user = User.find_by_uin(params[:uin])
    @uin = @user.uin

    puts "params #{params}"
    puts @uin

  end
  def do_transfer

    credit_num = params[:credits]
    puts "params: #{params}"
    puts params[:uin]
    puts credit_num

  end
end
