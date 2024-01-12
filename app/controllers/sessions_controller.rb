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
      if @user.valid?
        set_session
      else
        redirect_to '/', alert: 'Login failed.'
      end
    rescue StandardError
      session[:creating] = true
      redirect_to new_user_path({ email: auth['info']['email'], name: auth['info']['name'] })
    end
  end

  def set_session
    session[:user_id] = @user.id
    redirect_to '/users/profile', notice: 'You are logged in.'
  end

  def failure
    flash[:alert] = "Authentication failed. Please try again."
    redirect_to root_path
  end
end