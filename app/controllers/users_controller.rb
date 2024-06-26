# frozen_string_literal: true

$user_request_limit = 10

# controller class for Users
class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_admin, only: %i[admin_home admin_add_to_pool admin_subtract_from_pool]

  # ----------- admin specific controller methods ---------------

  def authenticate_admin
    @user = User.find(session[:user_id])
    return unless !@user || !@user.admin

    flash[:notice] = 'You are not authorized to access this page.'
    redirect_to root_path
  end

  def admin_home
    @user = User.find(session[:user_id])
    pool = CreditPool.find_by(email_suffix: @user.email.partition('@').last)
    @id_name = pool.presence ? pool.id_name : 'ID'
    @user_school = pool
  end

  def admin_add_to_pool
    # check to make value is an integer
    unless params[:credits].to_i.to_s == params[:credits]
      flash[:warning] = 'ERROR Invalid input!'
      redirect_to :admin_home
      return
    end

    num_credits = params[:credits].to_i
    @user = User.find(session[:user_id])

    if num_credits.zero? || num_credits.negative?
      flash[:warning] = 'ERROR Invalid input!'
      redirect_to :admin_home
      return
    end

    @creditpool = CreditPool.find_by(email_suffix: @user.email.partition('@').last)
    @creditpool.add_credits(num_credits)

    flash[:notice] = "CONFIRMATION Successfully added #{num_credits} credits to the pool!"
    redirect_to :admin_home
  end

  def admin_subtract_from_pool
    # check to make value is an integer
    unless params[:credits].to_i.to_s == params[:credits]
      flash[:warning] = 'ERROR Invalid input!'
      redirect_to :admin_home
      return
    end

    num_credits = params[:credits].to_i
    @user = User.find(session[:user_id])

    if num_credits.zero? || num_credits.negative?
      flash[:warning] = 'ERROR Invalid input!'
      redirect_to :admin_home
      return
    end

    @creditpool = CreditPool.find_by(email_suffix: @user.email.partition('@').last)

    if num_credits > @creditpool.credits
      flash[:warning] =
        "Can't subtract more credits than there are available, only #{@creditpool.credits} credits currently in pool"
      redirect_to :admin_home
      return
    end

    @creditpool.subtract_credits(num_credits)
    flash[:notice] = "CONFIRMATION Successfully subtracted #{num_credits} credits from the pool!"
    redirect_to :admin_home
  end

  # ----------- end of admin controller methods ---------------

  def index
    @users = User.all
  end

  def show
    @user = User.find(session[:user_id])
    pool = CreditPool.find_by(email_suffix: @user.email.partition('@').last)
    @id_name = pool.presence ? pool.id_name : 'ID'
    @user_school = pool
  end

  def new
    pool = CreditPool.find_by(email_suffix: session[:email].partition('@').last)
    @id_name = pool.presence ? pool.id_name : 'ID'
  end

  def edit; end

  def create
    new_params = new_user_params
    user_info = get_user_info new_params['uid']
    if user_info.key?('error')
      raise 'Error has occurred'
    elsif user_info['email'] != session[:email]
      pool = CreditPool.find_by(email_suffix: session[:email].partition('@').last)
      id_name = pool.presence ? pool.id_name : 'ID'
      raise "Email does not match the #{id_name}"
    elsif (new_params['user_type'] == 'recipient') && (user_info['credits'] > $user_request_limit)
      raise 'User has too many credits to create a receipent account'
    end

    # needs to change this after updating the external api, just the uin part
    @user = User.create!({ uid: user_info['uin'], name: "#{user_info['first_name']} #{user_info['last_name']}",
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
    # all we really want to do is set the global uid and user so we can use it later when we make our transfer call
    @user = User.find_by(id: session[:user_id])

    # puts "params #{params}"
    # puts @user.name
    @creditpool = CreditPool.find_by(email_suffix: @user.email.partition('@').last)
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
    # puts "uid #{params[:id]} is sending #{params[:credits]} credits to the pool"
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

    # send the number of transfered credits to the pool TODO: DRY above in page_load (session maybe?)
    @creditpool = CreditPool.find_by(email_suffix: @user.email.partition('@').last)

    # create a transaction object
    Transaction.create({ uid: @user.uid, transaction_type: 'donated', amount: num_credits,
                         credit_pool_id: @creditpool.id })

    @creditpool.add_credits(num_credits)

    # notify user it's successful somehow
    flash[:notice] = "CONFIRMATION Sucessfully donated #{num_credits} credits to the pool!"
    redirect_to :user_transfer
  end

  def receive
    @user = User.find_by(id: session[:user_id])
    @uid = @user.uid
    # puts "CREDIT POOL: " + @user.email.partition('@').last
    @creditpool = CreditPool.find_by(email_suffix: @user.email.partition('@').last)
    # puts "ACTUAL: " + CreditPool.all.length.to_s
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

    @creditpool = CreditPool.find_by(email_suffix: @user.email.partition('@').last)
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
    Transaction.create({ uid: @user.uid, transaction_type: 'received', amount: num_credits,
                         credit_pool_id: @creditpool.id })

    # notify user it's successful somehow
    flash[:notice] = "CONFIRMATION Sucessfully recieved #{num_credits} credits!"
    redirect_to :user_receive
  end

  def update_user_type
    @user = User.find_by(id: session[:user_id])
    new_user_type = params[:new_user_type]

    if (new_user_type != 'recipient') && (new_user_type != 'donor')
      flash[:warning] = "Error, invalid user type. User type must be 'donor' or 'recipient'"
      redirect_to :user_profile
      return -1
    end

    if (new_user_type == 'recipient') && (@user.fetch_num_credits > $user_request_limit)
      flash[:warning] = 'Too many credits to be a recipient'
      redirect_to :user_profile
      return
    end

    @user.update({ user_type: new_user_type })

    if @user.user_type == new_user_type
      flash[:notice] = "Type successfully updated to #{new_user_type}"
    else
      flash[:warning] = "Error updating user type to #{new_user_type}"
    end
    redirect_to :user_profile
  end

  def feedback
    @user = User.find_by(id: session[:user_id])
  end

  def submit_feedback
    @user = User.find_by(id: session[:user_id])
    ApplicationMailer.with(user: @user, feedback: params[:feedback]).feedback_email.deliver_now
    flash[:notice] = 'Feedback sent!'
    redirect_to :user_profile
  end

  private

  def new_user_params
    params.require(:user).permit(:uid, :user_type)
  end

  def get_user_info(uid)
    uri = URI("https://tamu-dining-62fbd726fd19.herokuapp.com/users/#{uid}")
    JSON.parse(Net::HTTP.get(uri))
  end
end
