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

  def do_transfer

    credit_num = params[:credits]
    @user = User.find_by_uin(params[:uin])
    puts "params: #{params}"
    puts @user
    puts credit_num

  end
end
