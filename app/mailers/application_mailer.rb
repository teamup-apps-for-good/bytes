# frozen_string_literal: true

# class for mailers
class ApplicationMailer < ActionMailer::Base
  default from: 'cyclone2531@gmail.com'
  layout 'mailer'

  def feedback_email
    gmail_credentials = Rails.application.credentials.gmail
    @user = params[:user]
    @feedback = params[:feedback]
    mail(to: gmail_credentials[:feedback_target], subject: 'Bytes Feedback')
  end
end
