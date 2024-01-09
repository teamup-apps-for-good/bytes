class TransactionsController < ApplicationController
  def index
    @transactions = Transaction.all
  end

  def new
  end

  def show
    id = params[:id]
    @transaction = Transaction.find(id)
  end

  def create
  end

  def edit
  end

  def update
  end

  def search
  end
end
