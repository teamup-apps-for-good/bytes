# frozen_string_literal: true

# controller class for Pages
class PagesController < ApplicationController
  skip_before_action :require_login, only: [:index]
  def index
    session.delete('email')
    return unless logged_in?

    redirect_to '/users/profile', notice: 'Welcome, back!'
  end
end
