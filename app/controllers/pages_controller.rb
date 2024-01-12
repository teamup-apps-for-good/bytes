# frozen_string_literal: true

class PagesController < ApplicationController
  skip_before_action :require_login, only: [:index]
  def index
    session[:creating] = false
    if logged_in?
      redirect_to '/users/profile', notice: 'Welcome, back!'
    end
  end
end
