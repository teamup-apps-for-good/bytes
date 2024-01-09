class PagesController < ApplicationController
  skip_before_action :require_login, only: [:index]
  def index
    if logged_in?
      redirect_to user_path(@current_user), notice: 'Welcome, back!'
    end
  end
end
