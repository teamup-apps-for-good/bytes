# frozen_string_literal: true

# controller class for Transactions
class TransactionsController < ApplicationController
  def index
    @user = User.find(session[:user_id])
    # @transactions = Transaction.all
    user_uin = User.find(session[:user_id]).uin
    @transactions = Transaction.where(uin: user_uin)
  end

  def show
    @user = User.find(session[:user_id])
    id = params[:id]
    @transaction = Transaction.find(id)
  end

  def new; end

  def edit; end
  def create; end

  def update; end

  def search; end
end
