# frozen_string_literal: true

$user_request_limit = 10

# controller class for Users
class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @users = User.all
  end

  def show
    @user = User.find(session[:user_id])
  end

  def new; end

  def edit; end

  def create
    new_params = new_user_params
    user_info = get_user_info new_params['uin']
    if user_info.key?('error')
      raise 'Error has occurred'
    elsif user_info['email'] != session[:email]
      raise 'Email does not match the UIN'
    elsif (new_params['user_type'] == 'recipient') && (user_info['credits'] > $user_request_limit)
      raise 'User has too many credits to create a receipent account'
    end

    @user = User.create!({ uin: user_info['uin'], name: "#{user_info['first_name']} #{user_info['last_name']}",
                           email: user_info['email'], user_type: new_params['user_type'], credits: 0 })
    flash[:notice] = %(#{@user.name}'s account was successfully created.)
    session[:user_id] = @user.id
    session.delete('email')
    redirect_to '/users/profile'
  rescue StandardError => e
    flash[:notice] = e.message
    redirect_to '/', alert: 'Login failed.'
  end

  def update; end

  def search; end

  def transfer
    # this is the controller for the actual transfer page
    # all we really want to do is set the global uin and user so we can use it later when we make our transfer call
    @user = User.find_by(id: session[:user_id])

    # puts "params #{params}"
    # puts @user.name

    raise StandardError, "There are multiple pools... there shouldn't be" if CreditPool.all.length > 1

    @creditpool = CreditPool.all[0]
    # puts "credit pool: #{@creditpool}"
  end

  def do_transfer
    # puts "INITIATING TRANSFER!"
    # grab who is doing the transfer, and how much

    unless params[:credits].to_i.to_s == params[:credits]
      flash[:notice] = 'ERROR Invalid input!'
      redirect_to :user_transfer
      return
    end
    num_credits = params[:credits].to_i
    id = session[:user_id]
    # puts "params: #{params}"
    # puts "uin #{params[:id]} is sending #{params[:credits]} credits to the pool"
    @user = User.find_by(id:)

    # check to see if there are any errors with credit amount
    if num_credits > @user.fetch_num_credits
      flash[:notice] = 'ERROR Trying to donate more credits than you have!'
      redirect_to :user_transfer
      return

    end

    if num_credits.zero? || num_credits.negative?
      flash[:notice] = 'ERROR Invalid input!'
      redirect_to :user_transfer
      return
    end

    # now, subtract credits from their account
    response = @user.update_credits(-1 * num_credits)

    # handles bad update_credit api call
    if response.code.to_i / 100 == 2
      # puts "Credit update successful"
    else
      flash[:warning] = "Error updating credits. Status code: #{response.code}"
      redirect_to :user_transfer
      return -1
    end

    # create a transaction object
    Transaction.create({ uin: @user.uin, transaction_type: 'donor', time: '', amount: num_credits })

    # send the number of transfered credits to the pool TODO: DRY above in page_load (session maybe?)
    raise StandardError, "There are multiple pools... there shouldn't be" if CreditPool.all.length > 1

    @creditpool = CreditPool.all[0]
    @creditpool.add_credits(num_credits)

    # notify user it's successful somehow
    flash[:notice] = "CONFIRMATION Sucessfully donated #{num_credits} credits to the pool!"
    redirect_to :user_transfer
  end

  def receive
    @user = User.find_by(id: session[:user_id])
    @uin = @user.uin

    raise StandardError, "There are multiple pools... there shouldn't be" if CreditPool.all.length > 1

    @creditpool = CreditPool.all[0]
  end

  def do_receive
    @user = User.find_by(id: session[:user_id])
    num_credits = params[:num_credits].to_i
    user_credits = @user.fetch_num_credits

    # handles invalid number of credits
    if num_credits <= 0
      flash[:notice] = 'ERROR Invalid input!'
      redirect_to :user_receive
      return -1
    end

    if user_credits >= $user_request_limit
      flash[:warning] = "Must have less than #{$user_request_limit} credits in order to make a request"
      redirect_to :user_receive
      return -1
    end

    @creditpool = CreditPool.all[0]
    # handles there not being enough credits for the request
    if num_credits > @creditpool.credits
      flash[:warning] = "Not enough credits available, only #{@creditpool.credits} credits currently in pool"
      redirect_to :user_receive
      return -1
    end

    if num_credits > $user_request_limit
      flash[:warning] = "Request too large, maximum allowed per request is #{$user_request_limit} credits"
      redirect_to :user_receive
      return -1
    end

    response = @user.update_credits(num_credits)

    # handles bad response from update_credit api call
    if response.code.to_i / 100 > 2
      flash[:warning] = "Error updating credits. Status code: #{response.code}"
      redirect_to :user_receive
      return -1
    end

    @creditpool.subtract_credits(num_credits)
    Transaction.create({ uin: @user.uin, transaction_type: 'received', time: '', amount: num_credits })

    # notify user it's successful somehow
    flash[:notice] = "CONFIRMATION Sucessfully recieved #{num_credits} credits!"
    redirect_to :user_receive
  end

  def update_user_type
    @user = User.find_by(id: session[:user_id])
    new_user_type = params[:new_user_type]

    if new_user_type != "recipient" and new_user_type != "donor"
      flash[:warning] = "Error, invalid user type. User type must be 'donor' or 'recipient'"
      return -1
    end

    if new_user_type == "recipient" and @user.credits > $user_request_limit
      flash[:warning] = "Too many credits to be a recipient"
      return
    end

    @user.update({ user_type: new_user_type })

    # notifies user whether type change is successful
    if @user.user_type == new_user_type
      flash[:notice] = "Type successfully updated to #{new_user_type}"
    else
      flash[:warning] = "Error updating user type to #{new_user_type}"
    end
  end

  private

  def new_user_params
    params.require(:user).permit(:uin, :user_type)
  end

  def get_user_info(uin)
    uri = URI("https://tamu-dining-62fbd726fd19.herokuapp.com/users/#{uin}")
    JSON.parse(Net::HTTP.get(uri))
  end
end
