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
end
