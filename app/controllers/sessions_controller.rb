# frozen_string_literal: true

# controller class for Sessions
class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:omniauth]

  def logout
    reset_session
    redirect_to root_path, notice: 'You are logged out.'
  end

  def omniauth
    auth = request.env['omniauth.auth']
    begin
      @user = User.find_by(email: auth['info']['email'])
      @user.set_admin
      set_session if @user.valid?
    rescue StandardError
      session[:email] = auth['info']['email']
      redirect_to new_user_path
    end
  end

  def set_session
    session[:user_id] = @user.id
    redirect_to '/users/profile', notice: 'You are logged in.'
  end

  # never gets called
  # def failure
  #   flash[:alert] = "Authentication failed. Please try again."
  #   redirect_to root_path
  # end
end
