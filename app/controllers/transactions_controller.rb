# frozen_string_literal: true

# controller class for Transactions
class TransactionsController < ApplicationController
  def index
    # @transactions = Transaction.all
    user_uin = User.find(session[:user_id]).uin
    @transactions = Transaction.where(uin: user_uin)
  end

  def new; end

  def show
    id = params[:id]
    @transaction = Transaction.find(id)
  end

  def create; end

  def edit; end

  def update; end

  def search; end

  def receive
    # @user = User.find_by_uin(params[:uin])
    # @uin = @user.uin

    raise StandardError, "There are multiple pools... there shouldn't be" if CreditPool.all.length > 1

    @creditpool = CreditPool.all[0]
    puts @creditpool
  end
end
