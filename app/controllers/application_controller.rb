# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :require_login

  private

  def current_user
    # if @current _user is undefined or falsy, evaluate the RHS
    #   RHS := look up user by id only if user id is in the session hash
    # question: what happens if session has user_id but DB does not?
    # ^ it will throw an error and you're stuck. to fix do this -> session.delete(:user_id)
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    # current_user returns @current_user,
    #   which is not nil (truthy) only if session[:user_id] is a valid user id
    current_user
  end

  def require_login
    # redirect to the  page unless user is logged in
    unless logged_in? or session[:creating]
        # puts "REDIRECTING TO HOME PAGE"
        redirect_to root_path, alert: 'You must be logged in to access this section.'
    end
  end
end
