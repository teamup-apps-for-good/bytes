class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:omniauth]
  
  def logout
    reset_session
    redirect_to root_path, notice: 'You are logged out.'
  end

  def omniauth  
    auth = request.env['omniauth.auth']
    # @user = User.find_or_create_by(uid: auth['uid'], provider: auth['provider']) do |u|
    #   u.email = auth['info']['email']
    #   names = auth['info']['name'].split
    #   u.name = names[0]
    # end
    begin
      @user = User.find_by(email: auth['info']['email'])
      if @user.valid?
        session[:user_id] = @user.id
        redirect_to user_path(@user), notice: 'You are logged in.'
      else    
        redirect_to '/', alert: 'Login failed.'
      end
    rescue
      session[:creating] = true 
      redirect_to new_user_path({:email => auth['info']['email'], :name => auth['info']['name']})
    end
  end
end
