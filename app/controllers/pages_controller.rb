# frozen_string_literal: true

# controller class for Pages
class PagesController < ApplicationController
  skip_before_action :require_login, only: [:index]
  def index

    #this block will fire, even if not logged in
    session.delete('email')

    #set a list of metrics to log
    metrics = [method(:num_meals_available),method(:num_schools_joined),method(:num_users_signedup),method(:num_meals)]

    #random index to pick one
    index = rand(0...metrics.length)
    
    #do the function corresponding to that metric
    metrics[index].call
    puts @metric_string

    return unless logged_in?

    #fires only when user is logged in, it will take them to the profile page since they're logged in
    redirect_to '/users/profile', notice: 'Welcome, back!'
  end

  def num_meals_available
    #get the number of meals available across all credit pools
    puts "meals avail"
    all_pools = CreditPool.all()
    total_credits = 0
    for pool in all_pools do
      total_credits += pool.credits
    end

    @metric_string = "Now over #{total_credits} meals available for students in need!"
  end

  def num_schools_joined
    #get the number of credit pools that exist
    puts "schools joined"
    all_pools = CreditPool.all()
    num_schools = all_pools.length

    @metric_string = "Now working with over #{num_schools} campuses. Join yours and be a change-maker today!"
  end

  def num_users_signedup

    #choose whether to display donor or receiver and do the count for whichever
    puts "users signedup"
    all_users = User.all()
    user_type_index = rand(0..1)
    user_count = 0
    for user in all_users do
      if user_type_index == 0 && user.user_type == 'donor'
        user_count +=1
      elsif user_type_index == 1 && user.user_type == 'recipient'
        user_count +=1
      end
    end

    #create the string, differently for if their a donor or recipient
    @metric_string = ""
    if user_type_index == 0
      @metric_string = "Join over #{user_count} students actively making a change in their community!"
    end
    if user_type_index == 1
      @metric_string = "Join over #{user_count} students recieving the aid they need!"
    end

  end

  def num_meals
    puts "meals donated"
    
    all_transactions = Transaction.all()

    #choose what kind of transaction to look for
    donated_or_recieved = rand(0..1)
    transaction_type_array = ["donated","received"]
    transaction_type = transaction_type_array[donated_or_recieved]

    #choose what time length
    time_index = rand(0..3) #today, this week, this month, this year
    time_string_array = ["today", "this week", "this month", "this year"]
    time_string = time_string_array[time_index]

    today = DateTime.now()
    res = 0

    #query for the number of transactions with a date in this time range
    case time_index
    when 0
      #look through transactions for the same day
      for transaction in all_transactions do
        if transaction_type == transaction.transaction_type && today.year == transaction.created_at.year && today.month == transaction.created_at.month && today.day == transaction.created_at.day
          res +=1
        end
      end
    when 1
      #look through transactions for the same week
      for transaction in all_transactions do
        if transaction_type == transaction.transaction_type && today.year == transaction.created_at.year && (today - 7.days >= transaction.created_at)
          res +=1
        end
      end
    when 2
      #look through transactions for same month
      for transaction in all_transactions do
        if transaction_type == transaction.transaction_type && today.year == transaction.created_at.year && today.month == transaction.created_at.month
          res +=1
        end
      end
    when 3
      #look through transactions for the same year
      for transaction in all_transactions do
        if transaction_type == transaction.transaction_type && today.year == transaction.created_at.year
          res +=1
        end
      end
    end

    @metric_string = "Over #{res} meals #{transaction_type} #{time_string}!"

  end


end
