# frozen_string_literal: true

# controller class for Transactions
class TransactionsController < ApplicationController
  def index
    @user = User.find(session[:user_id])
    # @transactions = Transaction.all
    @transactions = Transaction.where(uid: @user.uid).order(:created_at).reverse
    pool = CreditPool.find_by(email_suffix: @user.email.partition('@').last)
    @id_name = pool.presence ? pool.id_name : 'ID'
  end

  def show
    @transaction = Transaction.find(params[:id])
    @user = User.find(session[:user_id])
    pool = CreditPool.find_by(email_suffix: @user.email.partition('@').last)
    @id_name = pool.presence ? pool.id_name : 'ID'
  end

  def new; end

  def edit; end
  def create; end

  def update; end

  def search; end
end
