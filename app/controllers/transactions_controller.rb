# frozen_string_literal: true

# controller class for Transactions
class TransactionsController < ApplicationController
  def index
    @user = User.find(session[:user_id])
    # @transactions = Transaction.all
    @transactions = Transaction.where(uid: @user.uid).order(:created_at).reverse
    @id_name = CreditPool.find_by(email_suffix: @user.email.partition('@').last).id_name
  end

  def show
    @transaction = Transaction.find(params[:id])
    @user = User.find(session[:user_id])
    @id_name = CreditPool.find_by(email_suffix: @user.email.partition('@').last).id_name
  end

  def new; end

  def edit; end
  def create; end

  def update; end

  def search; end
end
