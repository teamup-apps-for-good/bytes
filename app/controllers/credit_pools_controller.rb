# frozen_string_literal: true

# controller class for CreditPools
class CreditPoolsController < ApplicationController
  before_action :set_credit_pool, only: %i[show edit update destroy]

  # GET /credit_pools or /credit_pools.json
  def index
    @credit_pools = CreditPool.all
  end

  # GET /credit_pools/1 or /credit_pools/1.json
  def show; end

  # GET /credit_pools/new
  def new
    @credit_pool = CreditPool.new
  end

  # GET /credit_pools/1/edit
  def edit; end

  # POST /credit_pools or /credit_pools.json
  def create
    @credit_pool = CreditPool.new(credit_pool_params)

    respond_to do |format|
      if @credit_pool.save
        format.html { redirect_to credit_pool_url(@credit_pool), notice: 'Credit pool was successfully created.' }
        format.json { render :show, status: :created, location: @credit_pool }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @credit_pool.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /credit_pools/1 or /credit_pools/1.json
  def update
    respond_to do |format|
      if @credit_pool.update(credit_pool_params)
        format.html { redirect_to credit_pool_url(@credit_pool), notice: 'Credit pool was successfully updated.' }
        format.json { render :show, status: :ok, location: @credit_pool }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @credit_pool.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /credit_pools/1 or /credit_pools/1.json
  def destroy
    @credit_pool.destroy!

    respond_to do |format|
      format.html { redirect_to credit_pools_url, notice: 'Credit pool was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_credit_pool
    @credit_pool = CreditPool.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def credit_pool_params
    params.require(:credit_pool).permit(:credits)
  end
end
