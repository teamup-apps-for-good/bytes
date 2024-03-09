class MeetingsController < ApplicationController
  before_action :set_uid, only: [:new, :create]

  def index
    @meetings = Meeting.all
    @user = User.find(session[:user_id])
  end

  def new
    @meeting = Meeting.new(uid: @current_uid)
  end

  def create
    @meeting = Meeting.new(meeting_params.merge(uid: @current_uid))
    if @meeting.save
      redirect_to meetings_path, notice: 'Meeting scheduled successfully.'
    else
      render :new
    end
  end

  private

  def set_uid
    @current_user = User.find(session[:user_id])
    @current_uid = current_user.uid
  end

  def meeting_params
    params.require(:meeting).permit(:date, :time, :location, :recurring)
  end
end
